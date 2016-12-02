package model;

import java.sql.Connection;
import java.sql.SQLException;

/***
 * Main program class.
 */
public class Program {

	public static void main(String[] args) throws SQLException {
		
		// Gets a database connection.
		Connection conn = Database.getConnection();
		
		//--a. 5 consultas básicas envolvendo os comandos distinct, order by,
		//--count(*), like, in e funções de manipulação de datas.
		System.out.println("-------------------------------CONSULTAS A-------------------------------");
		System.out.println("a. 5 consultas básicas envolvendo os comandos distinct, order by, ");
		System.out.println("count(*), like, in e funções de manipulação de datas.\n");
		
		//--A1) Quantidade de espécies distintas
		Consultas.consultaA1(conn);
		
		//--A2) Todos dinossauros do mais velho ao mais novo
		Consultas.consultaA2(conn);
		
		//--A3) Todas as espécies que não possuem 'sauro' no nome
		Consultas.consultaA3(conn);
		
		//--A4) Todas dinossaouros fêmeas que pesam menos que 10000kg e não são herbivoras
		Consultas.consultaA4(conn);
		
		//--A5) Todas os veículos que não estão ativos
		Consultas.consultaA5(conn);
		
		
		
		//--b. 5 consultas das quais 2 envolvam junções entre duas tabelas e 
		//--3 envolvam junções entre três ou mais tabelas.
		System.out.println("\n\n\n-------------------------------CONSULTAS B-------------------------------");
		System.out.println("b. 5 consultas das quais 2 envolvam junções entre duas tabelas e ");
		System.out.print("3 envolvam junções entre três ou mais tabelas.");
		
		//--B1) Quantidade de dinossauros e de espécies por área
		Consultas.consultaB1(conn);
		
		//--B2) Quantidade de funcionarios por funcao
		Consultas.consultaB2(conn);
		
		//--B3) Retorna os Eventos que possuem Tyranosaurus a partir da data e hora atual
		Consultas.consultaB3(conn);
		
		//--B4) Retorna os veículos que estão com algum funcionário
		Consultas.consultaB4(conn);
		
		//--B5) Retorna a quantidade de funcionários, a quantidade de dinossauros e a relação funcionário/dinossauro para cada área
		Consultas.consultaB5(conn);
		
		
		
		//--c. 5 consultas envolvendo group by e having, juntamente com funções
		//--de agregação.
		System.out.println("\n\n\n-------------------------------CONSULTAS C-------------------------------");
		System.out.println("c. 5 consultas envolvendo group by e having, juntamente com funções");
		System.out.print("de agregação.");
				
		//--C1) Retorna quantidade de veículos por ano
		Consultas.consultaC1(conn);
		
		//--C2) Retorna a media salarial dos funcionários por área
		Consultas.consultaC2(conn);
		
		//--C3) Status da capacidade de transporte da frota
		Consultas.consultaC3(conn);
		
		//--C4) Mostra as areas em que o menor salário é ao menos 6000
		Consultas.consultaC4(conn);
		
		//--C5) Mostra as áreas que tiverem eventos e somaram menos de 500 pessoas de público em eventos no último mês
		Consultas.consultaC5(conn);
		
		
		
		//--d. 5 consultas envolvendo sub-consultas.
		System.out.println("\n\n\n-------------------------------CONSULTAS D-------------------------------");
		System.out.print("d. 5 consultas envolvendo sub-consultas.");
		
		//--D1) Nome e altura dos dinossauros que habitam areas maiores de 5000m2
		Consultas.consultaD1(conn);
		
		//--D2) Nome e sexo dos funcionários que trabalham em terreno arenoso
		Consultas.consultaD2(conn);
		
		//--D3) Mostra funcionarios que trabalham no Sul
		Consultas.consultaD3(conn);
		
		//--D4) Mostra funções que trabalham no coberto e as áreas 
		Consultas.consultaD4(conn);
		
		//--D5) Mostra cada funcionário, e sua função, que tem fator multiplicativo maior que 1.5 e salário base maior que 5000
		Consultas.consultaD5(conn);
		
		
		conn.close();
	}

}
