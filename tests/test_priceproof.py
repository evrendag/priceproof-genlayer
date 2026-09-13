import json
URLS=json.dumps(["https://shop.example/product","https://shop.example/terms"])
SCOPE="Available to all customers in the United States without membership."
VERIFIED=json.dumps({"verdict":"VERIFIED","primary_gap":"NONE","score":94,"evidence_quality":"HIGH","observed_current_minor":79900,"observed_reference_minor":99900,"currency":"USD","summary":"Both official pages support the exact product, prices, eligibility and active offer period."})
PARTIAL=json.dumps({"verdict":"PARTIAL","primary_gap":"SCOPE","score":68,"evidence_quality":"HIGH","observed_current_minor":79900,"observed_reference_minor":99900,"currency":"USD","summary":"The advertised price is supported but the offer is limited to members rather than all customers."})
REJECTED=json.dumps({"verdict":"REJECTED","primary_gap":"PERCENTAGE","score":30,"evidence_quality":"HIGH","observed_current_minor":79900,"observed_reference_minor":89900,"currency":"USD","summary":"The official reference price does not support the advertised discount percentage."})
MISSING=json.dumps({"verdict":"INSUFFICIENT_EVIDENCE","primary_gap":"EVIDENCE","score":20,"evidence_quality":"LOW","observed_current_minor":0,"observed_reference_minor":0,"currency":"USD","summary":"The official pages are unavailable, so the offer cannot be verified safely."})
def deploy(direct_deploy):return direct_deploy("contract.py",sdk_version="v0.2.12")
def mock_pages(vm):vm.mock_web(r".*shop\.example.*",{"status":200,"body":"Pixel 10 Pro. Was USD 999.00, now USD 799.00. All customers. Offer active."})
def create(c):c.create_claim("shop.example","Pixel 10 Pro","USD",79900,99900,2002,SCOPE,URLS)
def test_create(direct_deploy):c=deploy(direct_deploy);create(c);assert c.get_claim(0).status=="SUBMITTED"
def test_bad_math_reverts(direct_vm,direct_deploy):
 c=deploy(direct_deploy)
 with direct_vm.expect_revert("Discount does not match"):c.create_claim("shop.example","Pixel 10 Pro","USD",79900,99900,5000,SCOPE,URLS)
def test_verified(direct_vm,direct_deploy):
 mock_pages(direct_vm);direct_vm.mock_llm(r".*",VERIFIED);c=deploy(direct_deploy);create(c);c.audit_claim(0);assert c.get_claim(0).status=="ACTIVE";assert direct_vm.run_validator() is True
def test_scope_partial(direct_vm,direct_deploy):
 mock_pages(direct_vm);direct_vm.mock_llm(r".*",PARTIAL);c=deploy(direct_deploy);create(c);c.audit_claim(0);assert c.get_receipt(0).primary_gap=="SCOPE"
def test_rejected_percentage(direct_vm,direct_deploy):
 mock_pages(direct_vm);direct_vm.mock_llm(r".*",REJECTED);c=deploy(direct_deploy);create(c);c.audit_claim(0);assert c.get_claim(0).status=="REJECTED"
def test_missing_fails_closed(direct_vm,direct_deploy):
 mock_pages(direct_vm);direct_vm.mock_llm(r".*",MISSING);c=deploy(direct_deploy);create(c);c.audit_claim(0);assert c.get_claim(0).status=="MANUAL_REVIEW"
