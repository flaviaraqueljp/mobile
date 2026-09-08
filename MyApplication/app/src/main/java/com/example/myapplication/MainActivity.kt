package com.example.myapplication
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import android.content.Intent
import androidx.activity.enableEdgeToEdge
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.updatePadding


class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        enableEdgeToEdge()
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.updatePadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        val btnCurso = findViewById<Button>(R.id.btnCurso)
        val btnDisciplinas = findViewById<Button>(R.id.btnDisciplinas)

        btnCurso.setOnClickListener {
            val intent = Intent(this, SobreCursoActivity::class.java)
            startActivity(intent)
        }

        btnDisciplinas.setOnClickListener {
            val intent = Intent(this, DisciplinasActivity::class.java)
            startActivity(intent)
        }
    }
}
