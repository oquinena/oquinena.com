#!/bin/bash
hugo

cd public
sshpass -e sftp ${USERNAME}@${URL} << EOF
put -r *
EOF
