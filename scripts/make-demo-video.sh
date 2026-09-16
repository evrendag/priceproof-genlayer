#!/usr/bin/env bash
set -euo pipefail

out_dir="/workspace/scratch/7cbe8d1a8ed8/priceproof-genlayer/.demo-frames"
out_file="/workspace/scratch/7cbe8d1a8ed8/PRICEPROOF-demo.mp4"
rm -rf "$out_dir"
mkdir -p "$out_dir"

for n in $(seq 0 5); do
  case "$n" in
    0) title="1  Connect your wallet"; detail="Approve MetaMask on GenLayer Studio Next (chain 61997)."; status="READY TO VERIFY"; step=1 ;;
    1) title="2  Pin the price claim"; detail="Freeze the merchant, product, currency and discount terms."; status="CLAIM SCOPE PINNED"; step=2 ;;
    2) title="3  Add official evidence"; detail="Validators reopen the live merchant pages independently."; status="EVIDENCE SEALED"; step=3 ;;
    3) title="4  Run consensus audit"; detail="Conflicting or inaccessible evidence fails closed."; status="VALIDATORS EXAMINING"; step=4 ;;
    4) title="5  Compare the facts"; detail="Current 79,900 USD  •  Reference 99,900 USD  •  20.02%"; status="CONSENSUS FINALIZED"; step=5 ;;
    5) title="6  Inspect the receipt"; detail="The result is challengeable, inspectable and recorded on-chain."; status="VERIFIED  •  94/100"; step=6 ;;
  esac
  pct=$((step * 16))
  convert -size 1280x720 xc:'#f4f1e8' \
    -fill '#ff5a36' -draw 'rectangle 0,0 1280,92' \
    -fill '#161814' -font DejaVu-Sans-Bold -pointsize 27 -annotate +58+48 'PRICEPROOF' \
    -font DejaVu-Sans -pointsize 16 -annotate +58+75 'Retail claims, cross-examined by GenLayer consensus' \
    -fill '#fffdf5' -stroke '#161814' -strokewidth 2 -draw 'roundrectangle 58,132 768,642 18,18' -stroke none \
    -fill '#e84c2e' -pointsize 15 -annotate +92+180 'LIVE OFFER DOCKET' \
    -fill '#161814' -font DejaVu-Sans-Bold -pointsize 32 -annotate +92+228 'Is the discount real?' \
    -font DejaVu-Sans -pointsize 19 -fill '#45483f' -annotate +92+272 "$detail" \
    -fill '#f4f1e8' -draw 'roundrectangle 92,312 734,370 9,9' -fill '#161814' -font DejaVu-Sans-Mono -pointsize 15 -annotate +112+348 'CONTRACT  0x89f972F5...B8b9D578' \
    -fill '#f4f1e8' -draw 'roundrectangle 92,392 734,450 9,9' -fill '#161814' -font DejaVu-Sans -pointsize 17 -annotate +112+428 'Google Store / Pixel 10 Pro / USD' \
    -fill '#161814' -draw 'roundrectangle 92,472 734,530 9,9' -fill '#fffdf5' -pointsize 17 -annotate +112+509 "$status" \
    -fill '#ded9ca' -draw 'roundrectangle 92,568 734,576 4,4' -fill '#ff5a36' -draw "roundrectangle 92,568 $((92+642*pct/100)),576 4,4" \
    -fill '#161814' -draw 'roundrectangle 820,132 1222,642 18,18' -fill '#ffb39e' -font DejaVu-Sans -pointsize 14 -annotate +858+180 'PRICE CLAIM RECEIPT' \
    -fill '#fffdf5' -font DejaVu-Sans-Bold -pointsize 64 -annotate +858+250 '94/100' -font DejaVu-Sans -pointsize 20 -fill '#ffb39e' -annotate +858+300 "$status" \
    -fill '#aeb3a4' -pointsize 15 -annotate +858+382 'OBSERVED CURRENT' -fill '#fffdf5' -pointsize 22 -annotate +858+409 '79,900 USD' \
    -fill '#aeb3a4' -pointsize 15 -annotate +858+455 'REFERENCE PRICE' -fill '#fffdf5' -pointsize 22 -annotate +858+482 '99,900 USD' \
    -fill '#aeb3a4' -pointsize 15 -annotate +858+528 'EVIDENCE QUALITY' -fill '#8dff9a' -pointsize 22 -annotate +858+555 'HIGH' \
    -fill '#aeb3a4' -pointsize 14 -annotate +858+603 'Studio Next / Chain 61997' "$out_dir/frame-$n.png"
done

ffmpeg -y -framerate 1/4 -i "$out_dir/frame-%d.png" -vf "scale=1280:720,format=yuv420p" -c:v libx264 -movflags +faststart "$out_file" >/dev/null 2>&1
echo "$out_file"
