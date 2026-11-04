package com.example.myapplication

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import android.content.Intent
import android.widget.TextView
import android.widget.Button


class DetalhesDisciplinaActivity : AppCompatActivity() {

    private val detalhes = mapOf(
        "Programação" to "Carga horária: 60h\nModalidade: Presencial\nNível: Básico\nPré-requisito: Nenhum",
        "Desenvolvimento Web" to "Carga horária: 70h\nModalidade: Online\nNível: Intermediário\nPré-requisito: Programação",
        "Desenvolvimento Mobile" to "Carga horária: 80h\nModalidade: Presencial\nNível: Intermediário\nPré-requisito: Programação",
        "Inteligência Artificial" to "Carga horária: 60h\nModalidade: Online\nNível: Avançado\nPré-requisito: Estrutura de Dados",
        "Engenharia de Software" to "Carga horária: 90h\nModalidade: Presencial\nNível: Intermediário\nPré-requisito: Programação",
        "Estrutura de Dados" to "Carga horária: 75h\nModalidade: Presencial\nNível: Intermediário\nPré-requisito: Programação"
    )

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_detalhes_disciplina)

        val nomeDisciplina = intent.getStringExtra("NOME_DISCIPLINA")

        val tvNome = findViewById<TextView>(R.id.tvNomeDisciplina)
        val tvDescricao = findViewById<TextView>(R.id.tvDescricao)
        val btnVoltar = findViewById<Button>(R.id.btnVoltar)
        val btnCompartilhar = findViewById<Button>(R.id.btnCompartilhar)

        tvNome.text = nomeDisciplina
        tvDescricao.text = detalhes[nomeDisciplina] ?: "Informações não disponíveis"

        btnVoltar.setOnClickListener {
            finish()
        }

        btnCompartilhar.setOnClickListener {
            val shareIntent = Intent(Intent.ACTION_SEND)
            shareIntent.type = "text/plain"
            shareIntent.putExtra(Intent.EXTRA_TEXT, "Disciplina: $nomeDisciplina\n${tvDescricao.text}")
            startActivity(Intent.createChooser(shareIntent, "Compartilhar via"))
        }
    }
}
