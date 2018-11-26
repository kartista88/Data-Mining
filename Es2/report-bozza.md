# Report 2

https://github.com/lucad93/Data-mining

## Problemi di classificaione

## 2018-11-22 main1
Abbiamo definito un problema di classificazione multiclasse.
Essendo un problema multiclasse è necessario utilizzare un metodo tipo one-vs-all oppure all-vs-all.
In questo caso utilizziamo un classificatore lineare con un metodo all-vs-all, in cui ogni classe è paragonata a tutte le altre ad ogni nuova iterazione dell'algoritmo.

Utilizzo come parametro di regolarizzazione lambda.
Per ottenere la soluzione ottima dividiamo il dataset in due insiemi: un learning set, corrispondente al 70% dei dati inizali e un validation set per poter calcolare l'errore commesso dal nostro modello ed eseguiamo un ciclo su diversi valori di lambda in modo da individuare il valore migliore.

Per mediare il risultato e minimizzare l'influenza della varianza ripetiamo questo procediamo un numero k di volte, con k uguale a 30 ad esempio.

// Grafico

## 2018-11-22 SVM
Definiamo un altro problema di classificazione che trattiamo questa volta con SVM.

Il termine di regolarizzazione che possiamo ottimizzare questa volta è il parametro C, tenendo conto che se usiamo valori bassi di C allora la soluzione sarà smooth, mentre se usiamo valori grandi per C ci interessiamo solo a minimizzare l'errore e avremo una soluzione più complicata.

Per ottimizzare il termine su C cicliamo su di esso per vari valori per trovare il vettore \alfa che più sparso, cioè con il maggior numero di zeri, e il modello w corrsipondente. A questo punto con il valore ottimo di C e il rispettivo modello plottiamo la soluzione.

// Grafico

## 2018-11-23 Decision tree
Implementiamo in questo esercizio un multiclass classification problem con un Decision Tree.
Iniziamo dal caso binario lo estendiamo al problema multiclasse.

Il parametro da ottimizzare in questo problema può essere la depth dell'albero. Anche in questo caso dividiamo il dataset in due insiemi, il learning set e il validation set e usando il validation set calcoliamo l'errore come numero di punti classificati in modo errato. Anche qui reiteriamo il prodcedimento k volte, con k uguale a 30.

// Grafico