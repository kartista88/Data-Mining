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
Definiamo un altro problema di classificazione che trattiamo questa volta con $SVM$.

In questo scenario il parametro da ottimizare è C: questo parametro può essere interpretato come l'inverso di $\lambda$, quindi per $C$ piccoli avremo un soluzione più smooth, mentre per $C$ grandi ci preoccuperemo solo di minimizzare l'errore.
Per fare ciò, al solito, dividiamo il dataset in due parti: Training Set e Validation Set e eseguiamo un ciclo sulla variabile C, memorizzando l'errore definito come numero di classificazioni sbagliate. Per minimizzare la varianza ripetiamo il procedimento k volte.
Una volta fatto questo cerchiamo nel vettore di errori quello con il minor numero di classificazioni sbagliate, il C corrispondente sarà C_{best}.

Ripetiamo, a questo punto il calcolo eseguito prima utilizzando $C_{best}$ al posto di $C$ e plottiamo la soluzione.

Nei due grafici sottostanti mostriamo due casi: nel primo, a parità di errore, scegliamo il $C_{best}$ più basso, quindi la soluzione sarà più semplice, ma meno precisa: ci saranno molti punti con $0<\alpha_i<=C$ (avremo un $\underline{w}$ basso), mentre nel secondo a parità di errore favoriamo il $C_{best}$ maggiore, quindi la soluzione sarà più complessa, ma con $\alpha$ più sparso.

// Grafico

## 2018-11-23 Decision tree
Implementiamo in questo esercizio un multiclass classification problem con un Decision Tree.
Iniziamo dal caso binario lo estendiamo al problema multiclasse.

Il parametro da ottimizzare in questo problema può essere la depth dell'albero. Anche in questo caso dividiamo il dataset in due insiemi, il learning set e il validation set e usando il validation set calcoliamo l'errore come numero di punti classificati in modo errato. Anche qui reiteriamo il prodcedimento k volte, con k uguale a 30.

// Grafico