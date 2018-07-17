# Specials

Special functions are functions that listen to every message (even messages
from bots), used for only _special circumstances_ (i.e., making an April
fools prank, writing joke replies, etc).

Specials are executed _before_ regular functions. All specials are executed, and
if a function returns a truthy value, Haruka will break out of `Haruka.try`.
