pai('José Custódio', 'Maria Carneiro').
pai('José Custódio', 'Edna Custódio').
pai('José Custódio', 'Luis Custódio').
pai('Geraldo Magela', 'Lilian Magela').
pai('Geraldo Magela', 'Renata Carneiro').
pai('Geraldo Magela', 'Rejane Carneiro').
pai('Luis Custódio', 'Francielly').
pai('João Coimbra', 'Ruggiery').
pai('Evanilton', 'Isadora').
pai('Paulo', 'Iury').
pai('Saturnino', 'Osório').
pai('Saturnino', 'José Proença').
pai('José Proença', 'Danila Proença').
pai('Calebe Chaves', 'Luiza').
pai('Osório', 'Juliano Proença').
pai('Juliano Proença', 'Arthur').
pai('Juliano Proença', 'Julia').

mae('Maria das Dores', 'Maria Carneiro').
mae('Maria das Dores', 'Edna Custódio').
mae('Maria das Dores', 'Luis Custódio').
mae('Maria Carneiro', 'Lilian Magela').
mae('Maria Carneiro', 'Renata Carneiro').
mae('Maria Carneiro', 'Rejane Carneiro').
mae('Mara Santos', 'Francielly').
mae('Edna Custódio', 'Ruggiery').
mae('Renata Carneiro', 'Isadora').
mae('Rejane Carneiro', 'Iury').
mae('Helena', 'Osório').
mae('Helena', 'José Proença').
mae('Maria Rodrigues', 'Danila Proença').
mae('Danila Proença', 'Luiza').
mae('Geracy', 'Juliano Proença').
mae('Lilian Magela', 'Arthur').
mae('Lilian Magela', 'Julia').

/* Avos  */
avo(X, Y) :- pai(X, P), pai(P, Y); mae(X, M), mae(M, Y).
avo(X, Y) :- pai(X, P), mae(P, Y); mae(X, P), pai(P, Y).
bisavo(X,Y) :- pai(X, V), avo(V, Y); mae(X, V), avo(V, Y).

/* Irmão */
irmao(X, Y) :- pai(P, X), pai(P, Y), mae(M, X), mae(M, Y), Y\==X. /* Em casos de irmão, retiramos a recorrência vide  */

/* Tios */
tio(X, Y) :- irmao(X, M), mae(M, Y); irmao(X, P), pai(P, Y), Y\==X.
tio-avo(X, Y) :- tio(X, E), mae(E, Y); tio(X, E), pai(E, Y), Y\==X.

/* Primos */
primo2(X, Y) :- tio-avo(E, X), pai(E, Y); tio-avo(E, X), mae(E, Y).

primo(X, Y) :- mae(M, X), mae(MM, Y), irmao(M, MM); pai(M, X), pai(MM, Y), irmao(M, MM).
primo(X, Y) :- primo2(X, Y); primo2(Y, X).
primo(X, Y) :- mae(E, X), primo2(Y, E).


/* Cunhado */
pais(X, Y) :- mae(X, E), pai(Y, E); mae(X, E), pai(Y, E).
filhos(X, Y) :- mae(Y, X); pai(Y, X).
cunhado(X, Y) :- irmao(X, E), pai(E, F), filhos(F, Y), E\==Y.
cunhado(X, Y) :- irmao(X, E), mae(E, F), filhos(F, Y), E\==Y.
cunhado(Y, X) :- irmao(X, E), mae(E, F), filhos(F, Y), E\==Y.