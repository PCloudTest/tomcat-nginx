export APP_ROOT=$HOME

conf_file=$APP_ROOT/.nginx/conf/nginx.conf
if [ -f $APP_ROOT/nginx.conf ]
then
  conf_file=$APP_ROOT/nginx.conf
fi

mv $conf_file $APP_ROOT/.nginx/conf/orig.conf
erb $APP_ROOT/.nginx/conf/orig.conf > $APP_ROOT/.nginx/conf/nginx.conf

# ------------------------------------------------------------------------------------------------

(tail -f -n 0 $APP_ROOT/.nginx/logs/*.log &)


exec $APP_ROOT/.nginx/sbin/nginx -p $APP_ROOT/.nginx -c $APP_ROOT/.nginx/conf/nginx.conf
# while true
# do