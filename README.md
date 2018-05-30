# README

Bubble-2•3•4 è un sito in cui possono essere condivise le proprie ricette di cocktails ed in cui è possibile interagire con gli altri barmen iscritti alla community, valutando e recensendo le loro creazioni.

Chiunque visiti il sito può cercare e visualizzare tutte le ricette, eventualmente filtrando i risultati per categoria oppure ordinandoli in base a determinati criteri (valutazioni, ordine alfabetico)

Ciascun utente che ha effettuato l’iscrizione alla community può condividere le sue migliori ricette di cocktails alle quali può allegare un’immagine ed eventualmente (tramite l’inserimento del rispettivo link) un video di YouTube in cui mostra la preparazione del drink: le API di Youtube si occuperanno di ottenere le informazioni riguardanti il video quali ID, data di pubblicazione, likes, dislikes, ecc…
Gli utenti registrati possono inoltre pubblicare recensioni, oppure semplicemente esprimere un voto riguardante ricette di altri utenti, aggiungere tali ricette ai preferiti, seguire un utente a cui sono interessati e scaricare le ricette in formato PDF così da poterle avere sempre a portata di mano.
Per gli utenti registrati è anche previsto un servizio di messaggistica in cui è possibile contattare privatamente gli altri membri della community.

Oltre alle funzionalità previste per chi è registrato al sito, gli utenti con privilegi di amministratore possono effettuare operazioni sulla base di dati come la cancellazione di utenti/ricette/commenti che magari possono essere ritenuti inappropriati.

Per quanto concerne l’autenticazione al sito, essa è prevista due maniere differenti:
• Locale: chiunque voglia registrarsi al sito può creare un profilo inserendo nome, cognome, nickname, email e password (ed eventualmente un avatar);
• OAuth: è possibile registrarsi al sito tramite i propri account Facebook e Google. Tramite le rispettive APIs è possibile reperire i dati dell’utente in modo tale da popolare le informazioni di quest’ultimo.

Tutto ciò che riguarda i dati degli utenti, le ricette e le rispettive recensioni/valutazioni è memorizzato su un database server-side.
