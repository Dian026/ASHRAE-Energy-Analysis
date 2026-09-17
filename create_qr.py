import qrcode

# Link zum GitHub-Projekt
url = "https://github.com/Dian026/ASHRAE-Energy-Analysis"

# QR-Code erstellen
qr = qrcode.make(url)

# QR-Code speichern
qr.save("ASHRAE_Energy_Analysis_QR.png")

print("QR-Code erfolgreich erstellt.")