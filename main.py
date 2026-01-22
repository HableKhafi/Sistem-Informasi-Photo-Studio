import sys
import mysql.connector
from PyQt5 import QtWidgets, QtCore
from PyQt5.QtWidgets import QMessageBox, QTableWidgetItem

# Import Semua UI
from form_login import Ui_Form as Ui_Login
from dashboard import Ui_Form as Ui_Dashboard
from form_user import Ui_Form as Ui_User
from form_customer import Ui_Form as Ui_Customer
from form_fotografer import Ui_Form as Ui_Fotografer
from form_produk import Ui_Form as Ui_Produk
from form_pembelian import Ui_Form as Ui_Pembelian
from form_penjualan import Ui_Form as Ui_Penjualan
from form_jadwal import Ui_Form as Ui_Jadwal

def get_db_connection():
    """Koneksi database terpusat"""
    return mysql.connector.connect(host="localhost", user="root", password="", database="photostudiodb")

# =========================================================
# BASE WINDOW: Logika Universal (Navigasi & CRUD Dasar)
# =========================================================
class BaseWindow(QtWidgets.QWidget):
    def __init__(self, ui_class, table_name, headers):
        super().__init__()
        self.ui = ui_class
        self.ui.setupUi(self)
        self.table_name = table_name
        self.headers = headers
        self.selected_id = None
        self.setup_sidebar()
        
        if hasattr(self.ui, 'tableWidget'):
            self.ui.tableWidget.setColumnCount(len(headers))
            self.ui.tableWidget.setHorizontalHeaderLabels(headers)
            self.ui.tableWidget.itemClicked.connect(self.get_data_to_input)
            self.load_data()
            self.inisialisasi_combobox()

        # Hubungkan tombol CRUD otomatis
        if hasattr(self.ui, 'pushButton_6'): self.ui.pushButton_6.clicked.connect(self.tambah_data)
        if hasattr(self.ui, 'pushButton_7'): self.ui.pushButton_7.clicked.connect(self.edit_data)
        if hasattr(self.ui, 'pushButton_8'): self.ui.pushButton_8.clicked.connect(self.hapus_data)

    def setup_sidebar(self):
        """Navigasi global antar modul"""
        try:
            self.ui.pushButton.clicked.connect(lambda: self.pindah_form(DashboardWindow))
            self.ui.pushButton_2.clicked.connect(lambda: self.pindah_form(UserWindow))
            self.ui.pushButton_11.clicked.connect(lambda: self.pindah_form(FotograferWindow))
            self.ui.pushButton_3.clicked.connect(lambda: self.pindah_form(ProdukWindow))
            self.ui.pushButton_4.clicked.connect(lambda: self.pindah_form(CustomerWindow))
            self.ui.pushButton_10.clicked.connect(lambda: self.pindah_form(PembelianWindow))
            self.ui.pushButton_5.clicked.connect(lambda: self.pindah_form(PenjualanWindow))
            self.ui.pushButton_9.clicked.connect(lambda: self.pindah_form(JadwalWindow))
        except AttributeError: pass

    def pindah_form(self, window_class):
        self.new_window = window_class(); self.new_window.show(); self.close()

    def load_data(self):
        """Ambil data dari MySQL"""
        try:
            conn = get_db_connection(); cursor = conn.cursor()
            cursor.execute(f"SELECT * FROM {self.table_name}")
            rows = cursor.fetchall()
            self.ui.tableWidget.setRowCount(0)
            for r_idx, r_data in enumerate(rows):
                self.ui.tableWidget.insertRow(r_idx)
                for c_idx, data in enumerate(r_data):
                    self.ui.tableWidget.setItem(r_idx, c_idx, QTableWidgetItem(str(data)))
            conn.close()
        except Exception as e: print(f"Load Error: {e}")

    def safe_get_text(self, row, col):
        """Hindari error NoneType"""
        item = self.ui.tableWidget.item(row, col)
        return item.text() if item else ""

    def load_combo(self, combo, table, col):
        """Isi ComboBox otomatis"""
        try:
            conn = get_db_connection(); cursor = conn.cursor()
            cursor.execute(f"SELECT {col} FROM {table}")
            items = cursor.fetchall()
            combo.clear()
            for i in items: combo.addItem(str(i[0]))
            conn.close()
        except Exception as e: print(f"Combo Error: {e}")

    def execute_sql(self, q, v, msg):
        """Fungsi eksekusi query tunggal"""
        try:
            conn = get_db_connection(); cursor = conn.cursor()
            cursor.execute(q, v); conn.commit(); conn.close()
            self.load_data(); QMessageBox.information(self, "Sukses", msg)
        except Exception as e: QMessageBox.critical(self, "Error SQL", str(e))

    # Placeholder fungsi yang wajib di-override di kelas anak
    def inisialisasi_combobox(self): pass
    def get_data_to_input(self): pass
    def tambah_data(self): pass
    def edit_data(self): pass
    def hapus_data(self):
        if not self.selected_id: return
        if QMessageBox.question(self, 'Hapus', f"Hapus ID {self.selected_id}?", QMessageBox.Yes|QMessageBox.No) == QMessageBox.Yes:
            self.execute_sql(f"DELETE FROM {self.table_name} WHERE id=%s", (self.selected_id,), "Data Terhapus")

# =========================================================
# MODUL MANAJEMEN: USER, CUSTOMER, FOTOGRAFER, PRODUK
# =========================================================

class UserWindow(BaseWindow):
    def __init__(self): super().__init__(Ui_User(), "user", ["ID","Nama","User","Pass","Akses","Telp","Email","Alamat"])
    def get_data_to_input(self):
        r = self.ui.tableWidget.currentRow(); self.selected_id = self.safe_get_text(r, 0)
        self.ui.lineEdit.setText(self.safe_get_text(r, 1)); self.ui.lineEdit_2.setText(self.safe_get_text(r, 2))
        self.ui.lineEdit_6.setText(self.safe_get_text(r, 3)); self.ui.comboBox.setCurrentText(self.safe_get_text(r, 4))
        self.ui.lineEdit_4.setText(self.safe_get_text(r, 5)); self.ui.lineEdit_3.setText(self.safe_get_text(r, 6))
        self.ui.lineEdit_5.setText(self.safe_get_text(r, 7))
    def tambah_data(self):
        v = (self.ui.lineEdit.text(), self.ui.lineEdit_2.text(), self.ui.lineEdit_6.text(), self.ui.comboBox.currentText(), self.ui.lineEdit_4.text(), self.ui.lineEdit_3.text(), self.ui.lineEdit_5.text())
        self.execute_sql("INSERT INTO user (nama_user, username, password, hak_akses, no_telp, email, alamat) VALUES (%s,%s,%s,%s,%s,%s,%s)", v, "User Ditambah")
    def edit_data(self):
        v = (self.ui.lineEdit.text(), self.ui.lineEdit_2.text(), self.ui.lineEdit_6.text(), self.ui.comboBox.currentText(), self.ui.lineEdit_4.text(), self.ui.lineEdit_3.text(), self.ui.lineEdit_5.text(), self.selected_id)
        self.execute_sql("UPDATE user SET nama_user=%s, username=%s, password=%s, hak_akses=%s, no_telp=%s, email=%s, alamat=%s WHERE id=%s", v, "User Diupdate")

class CustomerWindow(BaseWindow):
    def __init__(self): super().__init__(Ui_Customer(), "customer", ["ID","Nama","Alamat","Telp","Email","Member"])
    def get_data_to_input(self):
        r = self.ui.tableWidget.currentRow(); self.selected_id = self.safe_get_text(r, 0)
        self.ui.lineEdit.setText(self.safe_get_text(r, 1)); self.ui.lineEdit_2.setText(self.safe_get_text(r, 2))
        self.ui.lineEdit_6.setText(self.safe_get_text(r, 3)); self.ui.lineEdit_4.setText(self.safe_get_text(r, 4))
        self.ui.comboBox.setCurrentText(self.safe_get_text(r, 5))
    def tambah_data(self):
        v = (self.ui.lineEdit.text(), self.ui.lineEdit_2.text(), self.ui.lineEdit_6.text(), self.ui.lineEdit_4.text(), self.ui.comboBox.currentText())
        self.execute_sql("INSERT INTO customer (nama_customer, alamat, no_telp, email, jenis_member) VALUES (%s,%s,%s,%s,%s)", v, "Customer Ditambah")
    def edit_data(self):
        v = (self.ui.lineEdit.text(), self.ui.lineEdit_2.text(), self.ui.lineEdit_6.text(), self.ui.lineEdit_4.text(), self.ui.comboBox.currentText(), self.selected_id)
        self.execute_sql("UPDATE customer SET nama_customer=%s, alamat=%s, no_telp=%s, email=%s, jenis_member=%s WHERE id=%s", v, "Customer Diupdate")

class FotograferWindow(BaseWindow):
    def __init__(self): super().__init__(Ui_Fotografer(), "fotografer", ["ID","Nama","Telp","Email","Bidang","Alamat","User"])
    def inisialisasi_combobox(self): self.load_combo(self.ui.comboBox_2, "user", "id")
    def get_data_to_input(self):
        r = self.ui.tableWidget.currentRow(); self.selected_id = self.safe_get_text(r, 0)
        self.ui.lineEdit.setText(self.safe_get_text(r, 1)); self.ui.lineEdit_4.setText(self.safe_get_text(r, 2))
        self.ui.lineEdit_3.setText(self.safe_get_text(r, 3)); self.ui.comboBox.setCurrentText(self.safe_get_text(r, 4))
        self.ui.lineEdit_5.setText(self.safe_get_text(r, 5)); self.ui.comboBox_2.setCurrentText(self.safe_get_text(r, 6))
    def tambah_data(self):
        v = (self.ui.lineEdit.text(), self.ui.lineEdit_4.text(), self.ui.lineEdit_3.text(), self.ui.comboBox.currentText(), self.ui.lineEdit_5.text(), self.ui.comboBox_2.currentText())
        self.execute_sql("INSERT INTO fotografer (nama_fotografer, no_telp, email, spesialisasi, alamat, id_user) VALUES (%s,%s,%s,%s,%s,%s)", v, "Fotografer Ditambah")
    def edit_data(self):
        v = (self.ui.lineEdit.text(), self.ui.lineEdit_4.text(), self.ui.lineEdit_3.text(), self.ui.comboBox.currentText(), self.ui.lineEdit_5.text(), self.ui.comboBox_2.currentText(), self.selected_id)
        self.execute_sql("UPDATE fotografer SET nama_fotografer=%s, no_telp=%s, email=%s, spesialisasi=%s, alamat=%s, id_user=%s WHERE id=%s", v, "Fotografer Diupdate")

class ProdukWindow(BaseWindow):
    def __init__(self): super().__init__(Ui_Produk(), "produk", ["ID","Nama","Desc","Jual","Beli","Stok","Kat","Sup"])
    def inisialisasi_combobox(self):
        self.load_combo(self.ui.comboBox, "kategori", "id"); self.load_combo(self.ui.comboBox_2, "suplier", "id")
    def get_data_to_input(self):
        r = self.ui.tableWidget.currentRow(); self.selected_id = self.safe_get_text(r, 0)
        self.ui.lineEdit.setText(self.safe_get_text(r, 1)); self.ui.lineEdit_2.setText(self.safe_get_text(r, 2))
        self.ui.lineEdit_6.setText(self.safe_get_text(r, 3)); self.ui.lineEdit_7.setText(self.safe_get_text(r, 4))
        self.ui.lineEdit_4.setText(self.safe_get_text(r, 5)); self.ui.comboBox.setCurrentText(self.safe_get_text(r, 6))
        self.ui.comboBox_2.setCurrentText(self.safe_get_text(r, 7))
    def tambah_data(self):
        v = (self.ui.lineEdit.text(), self.ui.lineEdit_2.text(), self.ui.lineEdit_6.text(), self.ui.lineEdit_7.text(), self.ui.lineEdit_4.text(), self.ui.comboBox.currentText(), self.ui.comboBox_2.currentText())
        self.execute_sql("INSERT INTO produk (nama_produk, deskripsi, harga_jual, harga_beli, stok, id_kategori, id_suplier) VALUES (%s,%s,%s,%s,%s,%s,%s)", v, "Produk Ditambah")
    def edit_data(self):
        v = (self.ui.lineEdit.text(), self.ui.lineEdit_2.text(), self.ui.lineEdit_6.text(), self.ui.lineEdit_7.text(), self.ui.lineEdit_4.text(), self.ui.comboBox.currentText(), self.ui.comboBox_2.currentText(), self.selected_id)
        self.execute_sql("UPDATE produk SET nama_produk=%s, deskripsi=%s, harga_jual=%s, harga_beli=%s, stok=%s, id_kategori=%s, id_suplier=%s WHERE id=%s", v, "Produk Diupdate")

# =========================================================
# MODUL TRANSAKSI: PENJUALAN, PEMBELIAN, JADWAL FOTO
# =========================================================

class PenjualanWindow(BaseWindow):
    def __init__(self): super().__init__(Ui_Penjualan(), "penjualan", ["ID","Tgl","Inv","Bayar","Status","Total","User","Cust"])
    def inisialisasi_combobox(self):
        self.load_combo(self.ui.comboBox, "user", "id"); self.load_combo(self.ui.comboBox_4, "customer", "id")
    def get_data_to_input(self): # FIX: Mapping Lengkap Penjualan
        r = self.ui.tableWidget.currentRow(); self.selected_id = self.safe_get_text(r, 0)
        self.ui.lineEdit_4.setText(self.safe_get_text(r, 2)); self.ui.comboBox_2.setCurrentText(self.safe_get_text(r, 3))
        self.ui.comboBox_3.setCurrentText(self.safe_get_text(r, 4)); self.ui.lineEdit_3.setText(self.safe_get_text(r, 5))
        self.ui.comboBox.setCurrentText(self.safe_get_text(r, 6)); self.ui.comboBox_4.setCurrentText(self.safe_get_text(r, 7))
    def tambah_data(self):
        tgl = self.ui.dateTimeEdit.dateTime().toString("yyyy-MM-dd")
        v = (tgl, self.ui.lineEdit_4.text(), self.ui.comboBox_2.currentText(), self.ui.comboBox_3.currentText(), self.ui.lineEdit_3.text(), self.ui.comboBox.currentText(), self.ui.comboBox_4.currentText())
        self.execute_sql("INSERT INTO penjualan (tanggal, invoice, metode_bayar, status, total, id_user, id_customer) VALUES (%s,%s,%s,%s,%s,%s,%s)", v, "Transaksi Penjualan Berhasil")
    def edit_data(self): # FIX: Edit Penjualan
        tgl = self.ui.dateTimeEdit.dateTime().toString("yyyy-MM-dd")
        v = (tgl, self.ui.lineEdit_4.text(), self.ui.comboBox_2.currentText(), self.ui.comboBox_3.currentText(), self.ui.lineEdit_3.text(), self.ui.comboBox.currentText(), self.ui.comboBox_4.currentText(), self.selected_id)
        self.execute_sql("UPDATE penjualan SET tanggal=%s, invoice=%s, metode_bayar=%s, status=%s, total=%s, id_user=%s, id_customer=%s WHERE id=%s", v, "Penjualan Diupdate")

class PembelianWindow(BaseWindow):
    def __init__(self): super().__init__(Ui_Pembelian(), "pembelian", ["ID","Tgl","Bayar","Status","Total","User","Sup"])
    def inisialisasi_combobox(self):
        self.load_combo(self.ui.comboBox, "user", "id"); self.load_combo(self.ui.comboBox_4, "suplier", "id")
    def get_data_to_input(self): # FIX: Mapping Lengkap Pembelian
        r = self.ui.tableWidget.currentRow(); self.selected_id = self.safe_get_text(r, 0)
        self.ui.comboBox_2.setCurrentText(self.safe_get_text(r, 2)); self.ui.comboBox_3.setCurrentText(self.safe_get_text(r, 3))
        self.ui.lineEdit_3.setText(self.safe_get_text(r, 4)); self.ui.comboBox.setCurrentText(self.safe_get_text(r, 5))
        self.ui.comboBox_4.setCurrentText(self.safe_get_text(r, 6))
    def tambah_data(self):
        tgl = self.ui.dateTimeEdit.dateTime().toString("yyyy-MM-dd")
        v = (tgl, self.ui.comboBox_2.currentText(), self.ui.comboBox_3.currentText(), self.ui.lineEdit_3.text(), self.ui.comboBox.currentText(), self.ui.comboBox_4.currentText())
        self.execute_sql("INSERT INTO pembelian (tanggal, metode_bayar, status, total, id_user, id_suplier) VALUES (%s,%s,%s,%s,%s,%s)", v, "Transaksi Pembelian Berhasil")
    def edit_data(self): # FIX: Edit Pembelian
        tgl = self.ui.dateTimeEdit.dateTime().toString("yyyy-MM-dd")
        v = (tgl, self.ui.comboBox_2.currentText(), self.ui.comboBox_3.currentText(), self.ui.lineEdit_3.text(), self.ui.comboBox.currentText(), self.ui.comboBox_4.currentText(), self.selected_id)
        self.execute_sql("UPDATE pembelian SET tanggal=%s, metode_bayar=%s, status=%s, total=%s, id_user=%s, id_suplier=%s WHERE id=%s", v, "Pembelian Diupdate")

class JadwalWindow(BaseWindow):
    def __init__(self): super().__init__(Ui_Jadwal(), "jadwal_foto", ["ID","Tgl","Sesi","Status","Foto","Cust"])
    def inisialisasi_combobox(self):
        self.load_combo(self.ui.comboBox_2, "fotografer", "id"); self.load_combo(self.ui.comboBox_4, "customer", "id")
    def get_data_to_input(self): # FIX: Mapping Lengkap Jadwal
        r = self.ui.tableWidget.currentRow(); self.selected_id = self.safe_get_text(r, 0)
        self.ui.comboBox_5.setCurrentText(self.safe_get_text(r, 2)); self.ui.comboBox_3.setCurrentText(self.safe_get_text(r, 3))
        self.ui.comboBox_2.setCurrentText(self.safe_get_text(r, 4)); self.ui.comboBox_4.setCurrentText(self.safe_get_text(r, 5))
    def tambah_data(self):
        tgl = self.ui.dateTimeEdit.dateTime().toString("yyyy-MM-dd")
        v = (tgl, self.ui.comboBox_5.currentText(), self.ui.comboBox_3.currentText(), self.ui.comboBox_2.currentText(), self.ui.comboBox_4.currentText())
        self.execute_sql("INSERT INTO jadwal_foto (tanggal, jenis_sesi, status, id_fotografer, id_customer) VALUES (%s,%s,%s,%s,%s)", v, "Jadwal Disimpan")
    def edit_data(self): # FIX: Edit Jadwal
        tgl = self.ui.dateTimeEdit.dateTime().toString("yyyy-MM-dd")
        v = (tgl, self.ui.comboBox_5.currentText(), self.ui.comboBox_3.currentText(), self.ui.comboBox_2.currentText(), self.ui.comboBox_4.currentText(), self.selected_id)
        self.execute_sql("UPDATE jadwal_foto SET tanggal=%s, jenis_sesi=%s, status=%s, id_fotografer=%s, id_customer=%s WHERE id=%s", v, "Jadwal Diupdate")

# =========================================================
# DASHBOARD & LOGIN KETAT
# =========================================================

class DashboardWindow(BaseWindow):
    def __init__(self): super().__init__(Ui_Dashboard(), "", [])

class LoginWindow(QtWidgets.QWidget):
    def __init__(self):
        super().__init__(); self.ui = Ui_Login(); self.ui.setupUi(self)
        self.ui.pushButton_6.clicked.connect(self.login)
    def login(self):
        u, p = self.ui.lineEdit.text(), self.ui.lineEdit_2.text()
        if not u or not p: QMessageBox.warning(self, "Gagal", "Username & Password Wajib Diisi!"); return
        try:
            conn = get_db_connection(); cursor = conn.cursor()
            cursor.execute("SELECT * FROM user WHERE username=%s AND password=%s", (u, p))
            if cursor.fetchone(): # Verifikasi database
                self.d = DashboardWindow(); self.d.show(); self.close()
            else: QMessageBox.warning(self, "Gagal", "Username atau Password Salah!")
            conn.close()
        except Exception as e: QMessageBox.critical(self, "Error DB", str(e))

if __name__ == "__main__":
    app = QtWidgets.QApplication(sys.argv); win = LoginWindow(); win.show(); sys.exit(app.exec_())