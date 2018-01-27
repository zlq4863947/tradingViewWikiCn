git clean -i
git config --global http.postBuffer 1048576000
rm -rf _book
#rm -rf testPro
rm -rf hexo-site
gitbook build
git clone https://git.coding.net/ellite/hexo-site.git
#git clone https://git.coding.net/ellite/testPro.git
#cp -r _book/* testPro
#cd testPro
cp -r _book/* hexo-site/source/books/tradingview
cd hexo-site
git init
git add -A
git commit -m 'update book'
#git push --force --quiet "https://git.coding.net/ellite/testPro.git" HEAD:master
git push --force --quiet "https://git.coding.net/ellite/hexo-site.git" HEAD:master