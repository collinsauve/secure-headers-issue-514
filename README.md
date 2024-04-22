# secure-headers-issue-514
Demonstrating https://github.com/github/secure_headers/issues/514

# Reproduction:

Run the following:
```
bundle exec puma -p 3000
```

Then in another tab, use curl to view the full payload:

```
➜  curl http://localhost:3000 -D -
HTTP/1.1 200 OK
set-cookie: before-sh=hello
x-frame-options: sameorigin
x-content-type-options: nosniff
x-xss-protection: 1; mode=block
x-download-options: noopen
x-permitted-cross-domain-policies: none
content-security-policy: default-src 'self' https:; font-src 'self' https: data:; img-src 'self' https: data:; object-src 'none'; script-src https:; style-src 'self' https: 'unsafe-inline'
Content-Length: 11

Hello World
```

Note that only `before-sh` cookie is included.

# Without SecureHeaders

Just to demonstrate that all those cookies should be there, comment out the `use SecureHeaders::Middleware` line.  This will be the result:

```
➜  curl http://localhost:3000 -D -
HTTP/1.1 200 OK
set-cookie: after-sh-2=hello
set-cookie: after-sh-1=hello
set-cookie: before-sh=hello
Content-Length: 11

Hello World
```
