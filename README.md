# 動作手順

1. ローカルの開発環境を(--hostオプションを付けて)立ち上げる
1. dockerを--net=hostを付けて立ち上げる（devcontainer拡張機能で立ち上げると自動て付与します）
1. `tests/page.spec.ts`にテストしたいパス名一覧を追加する
1. pnpm test!
