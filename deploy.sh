rm -rf _book
rm -rf hexo-site
gitbook build
git clone https://git.coding.net/ellite/hexo-site.git
cp -r _book/* hexo-site/source/books/tradingview
cd hexo-site
git add -A
git commit -m 'update book'
git push