#! /usr/bin/sh

# sed -i //   

echo "\033[F\033[K **[ nginx serv ]** \n"
for seq in $(seq "10") ; do
    echo  "\033[F\033[K" waiting ... $seq
    sleep 0.2s
done

echo " \033[F\033[K\t[ go_!! ]\n serv : nginx starting"

exec nginx -g "daemon off;"
