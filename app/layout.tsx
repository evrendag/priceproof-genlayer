import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "PRICEPROOF — Retail claims, cross-examined",
  description: "Verify retail price and discount claims against live official evidence with GenLayer consensus.",
  icons: { icon: "/favicon.svg", shortcut: "/favicon.svg" },
};

export default function RootLayout({ children }: Readonly<{ children: React.ReactNode }>) {
  return <html lang="en"><body className="antialiased">{children}</body></html>;
}
