import { test, expect } from '@playwright/test';
test('Non drafts Page', async ({ page }) => {
  await page.goto('http://localhost:3003/slug');
  await expect(page).toHaveScreenshot({ maxDiffPixels: 100 });
});

test('Landing Page', async ({ page }) => {
  await page.goto('http://localhost:3000');
  await expect(page).toHaveScreenshot({ maxDiffPixels: 100 });
});

// TODO env variables
const people = ["planning-redux",
"basics",
"user-registration-and-management",
"planning",
"content-management",
"software-modularity",
"discussion",
"metadata",
"scaling",
"distributed-computing",
"user-activity-analysis",
"search"
]

for (const name of people) {

  test(`${name}`, async ({page}) => {
    await page.goto(`http://localhost:3000/${name}`);
    await expect(page).toHaveScreenshot({ maxDiffPixels: 100 });
  });
}