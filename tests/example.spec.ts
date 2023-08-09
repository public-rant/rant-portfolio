import { test, expect } from '@playwright/test';
test('Landing Page', async ({ page }) => {
  // # a post is
  // # <metadata>
  // # <layout>
  // # <navigation> (sitemap/related content)
  // # <sponsor> # github
  // # <contact> # netlify forms
  // # <draft> (introductory material)
  // # <code> (some sort of problem or assignment)
  // # <theory> js-algo or text book (advanced)

  await page.goto('http://localhost:3000');
  // await expect(page).toHaveScreenshot({ maxDiffPixels: 100 });
});


// TODO env variables
const experiments = [] as string[]
for (const experiment of experiments) {
  test(`${name}`, async ({page}) => {
    await page.goto(`http://localhost:3000/${experiment}`);
    await expect(page).toHaveScreenshot({ maxDiffPixels: 100 });
  });
}
