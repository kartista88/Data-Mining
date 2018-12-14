# Laboratorio su percetrone

## Implementaione del __Perceptron Learning Algorithm__

### Algoritmo
L'algoritmo così implementato divide già il _dataset_ in __Learning Set__ e __Validation Set__, con stesso metodo visto in classe nei precedenti laboratori.

_Immagine del codice che implementa l'algotritmo_

### Normalizzazione
Il dataset 'iris' va normalizzato tra 0 e 1, per farlo usiamo un intepolazione lineare.  
_immagine del codice di normalizzazione_

Inoltre, sempre nel caso di 'iris' riduciamo il numero di classi a 2, raggruppando gli elementi delle classi 2 e 3, e dandogli valore -1.  

_immagine del codice di riduzione del numero di classi_  

***

## Plot __OR__ e __Iris__

__OR__:  
_plot del separatore per __or___

__IRIS__:  
_plot del separatore per __iris___

## __Faces__ dataset
Rappresento come immagine i pesi (_w_) risultanti dall'algoritmo.  
As we can see, it looks like a face: we can distinguish the traits of the eyes, nose and mouth. The darkest zones are the most relevant for the classification, since the corresponding weights are larger there. It’s like this image is used as a filter, to be applied to the image we want to process.  
_Immagine dei pesi_  
Inoltre mostro l'immagine di un maschio e una femmina come esempio.
_Immagine maschio e femmina_  

***
### Valutazioni su numero di errori e numero di iterazioni

Rieseguento molteplici volte l'algoritmo sul dataset delle facce, dividendo il dataset iniziale a metà tra Learning Set e Validation Set otteniamo una media di iterazione di: 18524,846 e una media di errori pari a: 6,46.
Pertanto otteniamo in media un rapporto tra classificazione corretta ed errata di: 38,54/45 traducibile in 85,6% di accuratezza.

Ripetendo simili procedure per il dataset sonar otteniamo una percentuale di classificazioni accurate del 72,8%.

Aumentando la dimensione del training set notiamo un incremento nella precisone.

Per ottenere risultati migliori in termini di errore dovremmo disporre di dataset maggiori.