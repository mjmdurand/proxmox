linux_users:

  - name: alice
    groups:
      - sysadmin
      - sudo
    password: "password123"

  - name: bob
    groups:
      - dev
    generate_ssh: true

  - name: svc_backup
    groups:
      - backup
    shell: /usr/sbin/nologin
    password: "!"
