# Composed of IPAddr

Make it easier to store IPs in the db as 4-byte unsigned integers.
Indexes well and saves space over a varchar.

Pardon these implementation contortions. In our code, we can just work with an
`ipaddr` attribute using '1.2.3.4' strings and expect implicit coercion to
integers.

Requires an `int unsigned` column named `ipv4`.
