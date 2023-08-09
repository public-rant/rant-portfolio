
import {test} from '@playwright/test'
import { makeIssue } from 'astro/zod';
const job = process.env.JOB

test(`${job}`, async ({ page }) => {
  // todo write header for easier content extraction?
  await page.goto(`https://www.upwork.com/jobs/${job}`);
  await page.pdf({ path: `src/content/pdfs/${job}.pdf` });
});
