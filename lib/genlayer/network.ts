import { studioDevnet } from "genlayer-js/chains";

const chainId = Number(process.env.NEXT_PUBLIC_GENLAYER_CHAIN_ID ?? "61997");
const rpcUrl = process.env.NEXT_PUBLIC_GENLAYER_RPC_URL ?? "https://studio-next.genlayer.com/api";
const chainName = process.env.NEXT_PUBLIC_GENLAYER_CHAIN_NAME ?? "GenLayer Studio Next";

export const GENLAYER_CHAIN = {
  ...studioDevnet,
  id: chainId,
  name: chainName,
  rpcUrls: { default: { http: [rpcUrl] } },
  nativeCurrency: { name: "GEN", symbol: "GEN", decimals: 18 },
};

export const GENLAYER_NETWORK = {
  chainId: `0x${chainId.toString(16).toUpperCase()}`,
  chainName,
  nativeCurrency: GENLAYER_CHAIN.nativeCurrency,
  rpcUrls: [rpcUrl],
  blockExplorerUrls: ["https://explorer-studio-dev.genlayer.com/"],
};
