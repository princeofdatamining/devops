
if [ -z "$1" ]; then
  NEXTCLOUD="/var/www/nextcloud"
else
  NEXTCLOUD="$1"
fi

cat <<EOF > $NEXTCLOUD/config/apps.config.php
<?php
\$CONFIG = array (
  "appstoreenabled" => false,
  "apps_paths" => array (
      0 => array (
              "path"     => "$NEXTCLOUD/apps",
              "url"      => "/apps",
              "writable" => false,
      ),
      1 => array (
              "path"     => "$NEXTCLOUD/custom_apps",
              "url"      => "/custom_apps",
              "writable" => true,
      ),
  ),
);
EOF

chown -R apache:apache $NEXTCLOUD
chmod -R g=u $NEXTCLOUD

semanage fcontext -a -t httpd_sys_rw_content_t '$NEXTCLOUD/data(/.*)?'
semanage fcontext -a -t httpd_sys_rw_content_t '$NEXTCLOUD/config(/.*)?'
semanage fcontext -a -t httpd_sys_rw_content_t '$NEXTCLOUD/apps(/.*)?'
semanage fcontext -a -t httpd_sys_rw_content_t '$NEXTCLOUD/.htaccess'
semanage fcontext -a -t httpd_sys_rw_content_t '$NEXTCLOUD/.user.ini'

restorecon -Rv '$NEXTCLOUD'
