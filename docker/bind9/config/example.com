$TTL 2d

$ORIGIN example.com.

@               IN      SOA     ns.example.com. admin.kore-link.net. (
                                2022122800      ; serial
                                12h             ; refresh
                                15m             ; retry
                                3w              ; expire
                                2h              ; minimum ttl
                                )

                IN      NS      ns.example.com.

ns              IN      A       192.168.0.1

; -- add dns records below