package com.example.myapplication

import android.content.Intent
import android.os.Bundle
import android.widget.ArrayAdapter
import android.widget.ListView
import androidx.appcompat.app.AppCompatActivity
class DisciplinasActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_disciplinas)

        val disciplinas = listOf(
            "Programação",
            "Desenvolvimento Web",
            "Desenvolvimento Mobile",
            "Inteligência Artificial",
            "Engenharia de Software",
            "Estrutura de Dados"
        )

        val listView = findViewById<ListView>(R.id.listViewDisciplinas)
        val adapter = ArrayAdapter(this, android.R.layout.simple_list_item_1, disciplinas)
        listView.adapter = adapter

        listView.setOnItemClickListener { _, _, position, _ ->
            val disciplinaSelecionada = disciplinas[position]
            val intent = Intent(this, DetalhesDisciplinaActivity::class.java)
            intent.putExtra("NOME_DISCIPLINA", disciplinaSelecionada)
            startActivity(intent)
        }
    }
}
