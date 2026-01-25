# Lenket liste i Fortran 95

En enkel implementasjon av en enkeltlenket liste (singly linked list) i Fortran 95.

## Hva er dette?

Dette prosjektet inneholder en modul med en lenket liste som støtter vanlige operasjoner:
- Legge til elementer foran og bak (O(1))
- Fjerne første element (O(1))
- Søke etter verdier (O(n))
- Fjerne spesifikke verdier (O(n))
- Tømme hele listen (O(n))

Listen bruker hale-peker for å oppnå O(1) innsetting bak.

## Avhengigheter

- Fortran 95-kompilator (f.eks. gfortran)

### Installere gfortran

**macOS:**
```bash
brew install gcc
```

**Ubuntu/Debian:**
```bash
sudo apt install gfortran
```

**Fedora:**
```bash
sudo dnf install gcc-gfortran
```

## Kompilering

**Alt-i-ett:**
```bash
gfortran -std=f95 -Wall -Wextra -o linked_list linked_list.f95 main.f95
```

**Separate steg:**
```bash
gfortran -std=f95 -Wall -Wextra -c linked_list.f95
gfortran -std=f95 -Wall -Wextra -c main.f95
gfortran -o linked_list linked_list.o main.o
```

## Kjøring

```bash
./linked_list
```

## Eksempel på output

```
Testing linked list operations
==============================

Empty after init: T
Size after init: 0

push_back 10, 20, 30:
[10 20 30]
Size: 3

push_front 5:
[5 10 20 30]
Size: 4

find 20: T
find 99: F

remove_value 10:
Success: T
[5 20 30]
Size: 3

pop_front:
Success: T, Value: 5
[20 30]
Size: 2

Testing edge cases:
-------------------
remove_value 30 (tail):
Success: T
[20]

remove_value 20 (last element):
Success: T
[]
Empty: T

pop_front on empty list:
Success: F

remove_value on empty list:
Success: F

Refill and clear:
[100 200 300]
After clear:
[]
Empty: T
Size: 0
```

## Minnehåndtering

Koden allokerer og deallokerer noder korrekt. For å verifisere at det ikke er minnelekkasjer:

```bash
valgrind --leak-check=full ./linked_list
```

