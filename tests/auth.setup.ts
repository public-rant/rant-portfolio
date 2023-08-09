import { test as setup, expect } from '@playwright/test';

const authFile = 'playwright/.auth/user.json';

// setup('authenticate', async ({ page }) => {
//   // Perform authentication steps. Replace these actions with your own.
//   await page.goto('https://github.com/login');
//   await page.getByLabel('Username or email address').fill('username');
//   await page.getByLabel('Password').fill('password');
//   await page.getByRole('button', { name: 'Sign in' }).click();
//   // Wait until the page receives the cookies.
//   //
//   // Sometimes login flow sets cookies in the process of several redirects.
//   // Wait for the final URL to ensure that the cookies are actually set.
//   await page.waitForURL('https://github.com/');
//   // Alternatively, you can wait until the page reaches a state where all cookies are set.
//   await expect(page.getByRole('button', { name: 'View profile and more' })).toBeVisible();

//   // End of authentication steps.

// });
setup('auth', async ({ page }) => {
    await page.goto('https://www.upwork.com/');
    await page.getByRole('link', { name: 'Log in' }).click();
    await page.getByPlaceholder('Username or Email').click();
    await page.getByPlaceholder('Username or Email').click();
    await page.getByPlaceholder('Username or Email').fill('massey.upwork@icloud.com');
    await page.getByRole('button', { name: 'Continue with Email' }).click();
    await page.getByRole('textbox', { name: 'Password' }).click();
    await page.getByRole('textbox', { name: 'Password' }).fill('HQ705zkU');
    await page.getByRole('button', { name: 'Log in' }).click();
    await page.getByRole('button', { name: 'Try another method' }).click();
    await page.getByRole('button', { name: 'Accept All' }).click();
    await page.getByRole('button', { name: 'Send' }).click();
    await page.getByPlaceholder('Enter 6-digit code here').click();
    await page.pause()
    await page.getByPlaceholder('Enter 6-digit code here').fill('562221');
    await page.getByRole('button', { name: 'Next' }).click();
    await page.goto('https://www.upwork.com/nx/find-work/');
    await page.goto('https://www.upwork.com/nx/find-work/best-matches');
    await page.context().storageState({ path: authFile });
  });