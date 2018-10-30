# Brutta

## Primo esercizio

Regressione di una funzione nel caso monodimensionale
y = x^2 \x in [0,1]

Vengono definite la funzione da ricostruire, i campioni disturbati dal rumore, la varianza del rumore, 
il numero di campioni, il grado del polinomio regressore.

_inserire grafico della funzione e della sua predizione_

Si valuta come varia la precisione al variare di n (numero di campioni), p (grado del polinomio) e sigma (varianza del rumore), quindi anche in base alla variazione del rumore.
Viene perciò calcolato l'errore tra YT (funzione vera) e YP (predizione).

Notiamo che per rendere più precisa la misurazione dell'errore è meglio ripetere l'esperimento un numero elevato di volte,ad esempio vengono eseguite 30 ripetizioni della predizione.

Provando con alcuni valori di n[3,6,10,30] e p[0:5] diventa evidente come l'errore mantenga sempre lo steso trend

Con numero di campioni elevato, in generale, aumenta anche la precisione, mentre un aumento di p comporta una perdita di quest'ultima.
Risulta evidente coma la variazione dell'errore tra un'esecuzione dell'esercizio e l'altra sia minima per i valori maggiori di n.
In aggiunta si nota che per bassi valori di n è meglio utlizzare polinomi di grado basso, in quanto un eccessivo numero di gradi di libertà si traduce in unt tentativo della funzione di regressione di passare per ogni campione, rendendo di fatto la ricostruzione meno precisa, specie in prensenza di molto rumore, in quanto tenterà di passare per i campioni anche se rumorosi

_aggiungere grafico della funzione ricostruita con valori ottimi di n e p_

## Secondo esercizio

Ripeto la regressione polinomiale dell'esercizio precedente con l'aggiunta di regolarizzatore (bias).

Con l'uso del $ bias $ \lambda cerco di regolarizzare il mio polinomio: in sostanza aumetando lambda semplifico il mio risultato mentre dimunendolo utilizzo una funzione più complessa per la regressione, quindi modificare \lambda è concettualmente simile a cambiare il grado del polinomio, offrendo, però, una maggior granularità nella scelta del valore ottimale.
\Lambda rappresenta il livello di fiducia nella qualità dei dati in ingresso: più l'ingresso è rumoroso più conviene utilizzare \lambda grandi e quindi adottare soluzioni semplici in modo to not fit the noise, meno è rumoroso e più possiamo diminuire \lambda ed utilizzare soluzioni più comlplesse in order to fit data.

## Terzo esercizio -> kernel methods
Nel caso multidimensionale siamo limitati reegressioni di tipo polinomiale a causa della maledizione della dimensionalità,per questo utilizziamo metodi kernel, in particolare kernel gaussiano.

Usa due hyperparameters: 
- lambda che regolariza la soluzione -> consente di trovare un modello che sia smooth 
- i 3 hyperparameters del kernel, in questo caso si tiene conto solo di gamma: parametro che regola la no linearità della soluzione

ci sono combinazioni di lamda e gamma che più o meno portano alla stessa soluzione

Quindi labda e gamma sono parametri non completamente disconnessi, si possono trovare più o meno i soliti modelli con valori differenti di queste quantità.


Come trovare i valori migliori di labda e gamma:

We find best values of hyperparmeters through validation procedure (split the data, create the model with part of the data, and test the quality of hyperparmeters on a set of data that are not used during the model creation), the best combination of hypers is the one that minimize the error on the validation set( --> the set of data not used for creating the model)

La cosa migliore da fare è mediare i risultati.
Lo splitting dei dati non va fatto solo una volta, ma va ripetuto perché con una singola reliazzazione la varianza è più alta, ma se si prende la media sono più sicuro che il mio stimatore sia vicino alla media reale.

Osservazione:
il loop su k è messo come primo loop nella nostra implementazione (mettendolo all'interno potrei evitare di mantenere la matrice di tutti gli errori) perché la mia stima con k all'interno sarebbe soggetta a 2 tipi di varianza: una varianza dovuta allo stimatore stesso che non si può eliminare, l'altra è la varianza di come campiono il learning set e il validation set. Rischio di selezionare cattivi lamba e gamma perché la mia soluzione è determinata dalla varianza della qualità dello splitting. Scrivendo il codice come lo abbiamo scritto la splitting part è sempre la stessa per ogni gamma e lambda e questo riduce la varianza del mio stimatore.

Ultima osservazione: Il grafico, anche aumentando gamma, non passa da tutti i punti a causa della precisione a 64 bit che non è in grado di raggiungerli tutti.


## Real world problem
Affrontiamo come ultimo lab un problema del mondo reale.

Dopo aver compreso il problema e capito che metodo usare per risolverlo, procedo controllando i dati nel dataset:

- Categorical features
- Missing values
- Numerical problems

Normalizzo i dati in modo che ogni feature abbia lo stesso peso nella soluzione.

Controllo la distribuzione dei dati, controllando le varie feature controllo che possibilmente abbiano una distribuzione gaussiana: la distribuzione gaussiana indica che sono dati derivanti dalla natura.

Osserviamo che durante il calcolo si tengono 2 tipi di errori: 
- errore sulla validazione: usato per ottimizzare gamma e lambda
- errore sul test: mi dice che se prendo i dati faccio learning con quelle particulari gamma e lambda ottengo un modello con quel particolare ubiased error

Per verificare la bontà del modello non basta un singolo parametro (errore ad esempio), quindi stampo uno scatter plot: x axis -> true value, y axis -> prediction
Caso ideale: c'è una linea, quindi i valori coincidono esattamente
Nel caso reale: c'è una bolla, si forma un elipsoide intorno alla linea dritta
Utilizzare più dati per il learning può implementare la qualità della predizione, possiamo quindi cambiare le percentuali

Notiamo che lambda_best = 10^-4 e gamma_best = 2.2122
Lambda indica la smothness del modello e gamma ne indica la non linearità, ma di per sè non possiamo valutare se siano grandi o piccoli.
Per valutare se gamma sia grande o piccolo devo valutare la dimensionalità dello spazio, se sono un uno spazio a bassa dimensionalità 2 probabilmente è grande ma in uno spazio a grande dimensionalità probabilmente è piccolo, a sua volta lambda dipende dalla cardinalità dello spazio, accade che se abbiamo numeri piccoli in w, lambda sarà grande e quindi regolarizzo molto la soluzione.
