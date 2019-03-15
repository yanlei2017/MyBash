ssh-keygen
cat ~/.ssh/id_rsa.pub
ssh-add
ssh -T git@github.com

git config --global user.name yanlei
git config --global user.email 1028452050@qq.com

git config --global --unset https.proxy 
git config --global --unset http.proxy 

git config --global https.proxy socks5://127.0.0.1:2333
git config --global http.proxy socks5://127.0.0.1:2333
