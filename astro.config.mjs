import { defineConfig } from 'astro/config';
import mdx from "@astrojs/mdx";

import netlify from "@astrojs/netlify/functions";

// https://astro.build/config
export default defineConfig({
  output: 'server',
  integrations: [mdx()],
  adapter: netlify()
});