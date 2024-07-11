import { test, expect } from '@playwright/test';

test.describe.configure({ mode: 'parallel' });

// ここにテストするURLリスト(オリジン抜き)を追加する
const pathnames = []

for (const pathname of pathnames) {
  test(`should not have a noindex meta tag on '${pathname}'`, async ({ page }) => {
    await page.goto(`http://host.docker.internal:3000/${pathname}`);

    // metaタグがページに存在するかどうかを確認
    const metaTag = await page.$('meta[name="robots"][content="noindex"]');

    expect(metaTag).toBe(null)
  });
}