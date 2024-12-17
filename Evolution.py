import tkinter as tk
from tkinter import ttk

# Lista pytań i odpowiedzi
pytania = [
    {"pytanie": "Wybierz ulubiony kolor:", "opcje": ["Czerwony", "Zielony", "Niebieski"]},
    {"pytanie": "Wybierz ulubione zwierzę:", "opcje": ["Kot", "Pies", "Królik"]},
    {"pytanie": "Wybierz ulubiony napój:", "opcje": ["Kawa", "Herbata", "Sok"]},
]

# Zmienna do śledzenia aktualnego pytania
indeks_pytania = 0





# Funkcja do zmiany pytania i opcji
def zmien_pytanie():
    global indeks_pytania
    indeks_pytania += 1
    if indeks_pytania >= len(pytania):  # Jeśli to ostatnie pytanie, wracamy do początku
        indeks_pytania = 0
    
    # Pobierz aktualne pytanie i opcje
    aktualne_pytanie = pytania[indeks_pytania]
    etykieta_opis.config(text=aktualne_pytanie["pytanie"])
    
    # Aktualizuj tekst przycisków radiowych
    for i, opcja in enumerate(aktualne_pytanie["opcje"]):
        radio_buttons[i].config(text=opcja, value=opcja)
    
    # Resetuj wybór
    zmienna.set(aktualne_pytanie["opcje"][0])
    etykieta_wynik.config(text="Wybierz opcję powyżej")





# Funkcja do wyświetlania aktualnego wyboru
def pokaz_wybor():
    wybor = zmienna.get()
    etykieta_wynik.config(text=f"Wybrałeś: {wybor}")

# Tworzenie głównego okna
okno = tk.Tk()
okno.title("Quiz z Radio Buttons")
okno.geometry("600x400")

# Tworzenie zmiennej do przechowywania wyboru
zmienna = tk.StringVar(value=pytania[0]["opcje"][0])

# Tworzenie etykiety dla pytania
etykieta_opis = tk.Label(okno, text=pytania[0]["pytanie"], font=("Arial", 14))
etykieta_opis.grid(row=0, column=0, columnspan=2, pady=20)

# Tworzenie przycisków radiowych
radio_buttons = []
for i, opcja in enumerate(pytania[0]["opcje"]):
    radio = ttk.Radiobutton(okno, text=opcja, value=opcja, variable=zmienna, command=pokaz_wybor)
    radio.grid(row=i+1, column=0, sticky="w", padx=20, pady=5)
    radio_buttons.append(radio)

# Etykieta do wyświetlania wyboru
etykieta_wynik = tk.Label(okno, text="Wybierz opcję powyżej", font=("Arial", 14))
etykieta_wynik.grid(row=4, column=0, columnspan=2, pady=20)

# Przycisk "Następne pytanie"
przycisk_nastepne = ttk.Button(okno, text="Następne pytanie", command=zmien_pytanie)
przycisk_nastepne.grid(row=5, column=0, columnspan=2, pady=20)

# Uruchomienie pętli głównej aplikacji
okno.mainloop()
