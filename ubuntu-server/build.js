import envsub from "envsub";
import { dirname, join } from "path";
import { fileURLToPath } from "url";
import { readdir } from "fs/promises";

(async () => {
  const currentDir = dirname(fileURLToPath(import.meta.url));
  const srcDir = join(currentDir, "src");
  const distDir = join(currentDir, "dist");

  // Get the full paths
  const templateFile = join(srcDir, "user-data");
  const outputFile = join(distDir, "user-data");

  const options = {
    all: false,
    envFiles: [`${currentDir}/.env`],
    protect: true,
    syntax: "dollar-both",
  };

  await envsub({ templateFile, outputFile, options });
})();
