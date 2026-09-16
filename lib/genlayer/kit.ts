"use client";

import { createTransactionKit, type TransactionKit } from "@genlayer/transaction-kit";
import { useMemo } from "react";
import { GENLAYER_CHAIN } from "./network";

type EthereumProvider = {
  request(args: { method: string; params?: unknown[] }): Promise<unknown>;
};

/** Creates the Studio Next Transaction Kit for fee-aware submissions. */
export function useGenLayerTransactionKit(address: string | null): TransactionKit | null {
  return useMemo(() => {
    if (typeof window === "undefined" || !address || !window.ethereum) return null;
    return createTransactionKit({
      chain: GENLAYER_CHAIN,
      provider: window.ethereum as EthereumProvider,
      account: address as `0x${string}`,
    });
  }, [address]);
}
