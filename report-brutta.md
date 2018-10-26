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

Usa due hyperparameters: lambda che regolariza la soluzione-> finding a model which is smooth 

3 hyperparameters in this case is only gamma regulats the non linearity of the solution  

ci sono ombinazioni di lamda e gamma che portano alla stessa soluzione

parametri non completamente disconnessi in questo si trovano più o meno i soliti modelli con valori differenti di questi parametri

best values

validation procedure

the one that minimize the error on the validation set(the set of data not used for creating the model)

best thing to do is to average the result -> non solo dividere i dati 1 volra sola ma ripetere and take the average outcome -> my estimator is more close to the actual real value
