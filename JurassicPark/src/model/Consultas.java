package model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


public class Consultas {
	//-----------------------------------------CONSULTAS A-----------------------------------------
	//--A1) Quantidade de espécies distintas
	public static void consultaA1(Connection connection) throws SQLException {
		String sql = "SELECT COUNT(DISTINCT dino.especie) qtd_especies " + 
					 "FROM tb_dinossauros dino";
		Statement statement = connection.createStatement();
		ResultSet rs = statement.executeQuery(sql);

		while (rs.next()) {
			int QTD_ESPECIES = rs.getInt("qtd_especies");			
			System.out.println("Consulta a1) Quantidade de espécies distintas: " + QTD_ESPECIES);
		}
		
		statement.close();
		rs.close();
	}
	
	//--A2) Todos dinossauros do mais velho ao mais novo
	public static void consultaA2(Connection connection) throws SQLException {
		String sql = "SELECT dino.nome NOME, dino.especie ESPECIE, FLOOR((SYSDATE - dino.nascimento)/365) IDADE " + 
				 "FROM tb_dinossauros dino " + 
				 "ORDER BY IDADE DESC";
		Statement statement = connection.createStatement();
		ResultSet rs = statement.executeQuery(sql);
		
		System.out.println("\n\nConsulta a2) Todos dinossauros do mais velho ao mais novo:");
		System.out.println("NOME, ESPÉCIE, IDADE");
		while (rs.next()) {
			String nome = rs.getString("nome");
			String especie = rs.getString("especie");
			int idade = rs.getInt("idade");			
			System.out.println(nome + ", " + especie + ", " + idade + " anos");
		}
		
		statement.close();
		rs.close();
	}
	
	//--A3) Todas as espécies que não possuem 'sauro' no nome
	public static void consultaA3(Connection connection) throws SQLException {
		String sql = "SELECT DISTINCT dino.especie ESPECIE " + 
				 "FROM tb_dinossauros dino " + 
				 "WHERE dino.especie NOT LIKE '%sauro%'";
		Statement statement = connection.createStatement();
		ResultSet rs = statement.executeQuery(sql);
		
		System.out.println("\n\nConsulta a3) Todas as espécies que não possuem 'sauro' no nome:");
		while (rs.next()) {			
			String especie = rs.getString("especie");			
			System.out.println(especie);
		}
		
		statement.close();
		rs.close();
	}	

	//--A4) Todas dinossaouros fêmeas que pesam menos que 10000kg e não são herbivoras
	public static void consultaA4(Connection connection) throws SQLException {
		String sql = "SELECT * " + 
				 "FROM tb_dinossauros dino " + 
				 "WHERE dino.sexo like 'F' AND dino.peso < 10000 AND dino.dieta like 'H'";
		Statement statement = connection.createStatement();
		ResultSet rs = statement.executeQuery(sql);
		
		System.out.println("\n\nConsulta a4) Todas dinossaouros fêmeas que pesam menos que 10000kg e não são herbivoras:");
		System.out.println("NOME, NOME_CIENTÍFICO, ESPÉCIE, SEXO, PESO, DIETA, ÉPOCA");
		while (rs.next()) {			
			String nome = rs.getString("nome");
			String nomeCientifico = rs.getString("nomecientifico");
			String especie = rs.getString("especie");
			String sexo = rs.getString("sexo");
			int peso = rs.getInt("peso");
			String dieta = rs.getString("dieta");
			String epoca = rs.getString("epoca");
			System.out.println(nome + ", " + nomeCientifico + ", " + especie + ", " + sexo + ", " + 
						peso + "kg, " + dieta + ", " + epoca);
		}
		
		statement.close();
		rs.close();		
	}
	
	//--A5) Todas os veículos que não estão ativos
	public static void consultaA5(Connection connection) throws SQLException {
		String sql = "SELECT veiculo.placa PLACA, veiculo.status STATUS " + 
				 "FROM tb_veiculos veiculo " + 
				 "WHERE veiculo.status IN ('M', 'I')";
		Statement statement = connection.createStatement();
		ResultSet rs = statement.executeQuery(sql);
		
		System.out.println("\n\nConsulta a5) Todas os veículos que não estão ativos:");
		System.out.println("PLACA, STATUS");
		while (rs.next()) {
			String placa = rs.getString("placa");
			String status = rs.getString("status");		
			System.out.println(" " + placa + ", " + status);
		}
		
		statement.close();
		rs.close();
	}
	
	
	
	//-----------------------------------------CONSULTAS B-----------------------------------------
	//--B1) Quantidade de dinossauros e de espécies por área
	public static void consultaB1(Connection connection) throws SQLException {
		String sql = "SELECT area.nomearea AREA, COUNT(dino.id_dino) QTD_DINOS, COUNT(DISTINCT dino.especie) QTD_ESPECIES " + 
				 "FROM tb_dinossauros dino INNER JOIN tb_areas area ON dino.id_area = area.id_area " + 
				 "GROUP BY area.nomearea";
		Statement statement = connection.createStatement();
		ResultSet rs = statement.executeQuery(sql);
		
		System.out.println("\n\nConsulta b1) Quantidade de dinossauros e de espécies por área:");
		System.out.println("AREA, QTD_DINOS, QTD_ESPECIES");
		while (rs.next()) {
			String area = rs.getString("area");
			int qtdDinos = rs.getInt("qtd_dinos");
			int qtdEspecies = rs.getInt("qtd_especies");			
			System.out.println(area + ", " + qtdDinos + ", " + qtdEspecies);
		}
		
		statement.close();
		rs.close();
	}
	
	//--B2) Quantidade de funcionarios por funcao
	public static void consultaB2(Connection connection) throws SQLException {
		String sql = "SELECT funcao.funcao FUNCAO, COUNT(func.id_funcionario) QTD_FUNCIONARIOS " + 
				 "FROM tb_funcoes funcao INNER JOIN tb_funcionarios func ON funcao.id_funcao = func.id_funcao " + 
				 "GROUP BY funcao.funcao " +
				 "ORDER BY FUNCAO";
		Statement statement = connection.createStatement();
		ResultSet rs = statement.executeQuery(sql);
		
		System.out.println("\n\nConsulta b2) Quantidade de funcionários por função:");
		System.out.println("FUNÇÃO, QTD_FUNCIONARIOS");
		while (rs.next()) {
			String funcao = rs.getString("funcao");
			int qtdFuncionarios = rs.getInt("qtd_funcionarios");			
			System.out.println(funcao + ", " + qtdFuncionarios);
		}
		
		statement.close();
		rs.close();
	}
		
	//--B3) Retorna os Eventos que possuem Tyrannosaurus a partir da data e hora atual
	public static void consultaB3(Connection connection) throws SQLException {
		String sql = "SELECT dino.nome, atracao.nome EVENTO, area.nomearea AREA, TO_CHAR(evento.datahoraevento, 'dd/mm/yyyy hh24:mi') HORA, evento.qtdpublico CAPACIDADE " +
				 "FROM tb_dinossauros dino " + 
				 "INNER JOIN tb_areas area ON dino.id_area = area.id_area " +
				 "INNER JOIN tb_areasatracoes evento ON area.id_area = evento.id_area " +
				 "INNER JOIN tb_atracoes atracao ON atracao.id_atracao = evento.id_atracao " +
				 "WHERE dino.nomeCientifico LIKE 'Tyrannosaurus%' AND evento.datahoraevento >= SYSDATE " +
				 "ORDER BY HORA";
		Statement statement = connection.createStatement();
		ResultSet rs = statement.executeQuery(sql);
		
		System.out.println("\n\nConsulta b3) Retorna os Eventos que possuem Tyrannosaurus a partir da data e hora atual:");
		System.out.println("NOME_DINO, EVENTO, AREA, HORA_DATA, CAPACIDADE");
		while (rs.next()) {			
			String nome = rs.getString("nome");		
			String evento = rs.getString("evento");
			String area = rs.getString("area");
			String hora = rs.getString("hora");
			int capacidade = rs.getInt("capacidade");
			System.out.println(nome + ", " + evento + ", " + area  + ", " + hora + ", " + capacidade);
		}
		
		statement.close();
		rs.close();
	}
	
	//--B4) Retorna os veículos que estão com algum funcionário
	public static void consultaB4(Connection connection) throws SQLException {
		String sql = "SELECT vec.placa PLACA, func.nome NOME, funcvec.retirada RETIRADA, funcvec.devolucao DEVOLUCAO " + 
				 "FROM tb_veiculos vec " + 
				 "INNER JOIN tb_funcionariosveiculos funcvec ON vec.placa = funcvec.placa " +
				 "INNER JOIN tb_funcionarios func ON funcvec.id_funcionario = func.id_funcionario " +
				 "WHERE funcvec.devolucao IS NULL " +
				 "ORDER BY RETIRADA";
		Statement statement = connection.createStatement();
		ResultSet rs = statement.executeQuery(sql);
		
		System.out.println("\n\nConsulta b4) Retorna os veículos que estão com algum funcionário:");
		System.out.println("PLACA, NOME, RETIRADA");
		while (rs.next()) {
			String placa = rs.getString("placa");
			String nome = rs.getString("nome");
			String retirada = rs.getString("retirada");
			System.out.println(placa + ", " + nome + ", " + retirada);
		}
			
		statement.close();
		rs.close();
	}
	
	//--B5) Retorna a quantidade de funcionários, a quantidade de dinossauros e a relação funcionário/dinossauro para cada área
	public static void consultaB5(Connection connection) throws SQLException {
		String sql = "SELECT area.nomearea AREA, COUNT(DISTINCT func.id_funcionario) QTD_FUNCIONARIOS, COUNT(DISTINCT dino.id_dino) QTD_DINOS, ROUND(COUNT(DISTINCT func.id_funcionario)/COUNT(DISTINCT dino.id_dino),2) RELACAO " +
				 "FROM tb_funcionarios func " + 
				 "INNER JOIN tb_areas area ON func.id_area = area.id_area " +
				 "INNER JOIN tb_dinossauros dino ON area.id_area = dino.id_area " +
				 "GROUP BY (area.nomearea)";
		Statement statement = connection.createStatement();
		ResultSet rs = statement.executeQuery(sql);
		
		System.out.println("\n\nConsulta b5) Retorna a quantidade de funcionários, a quantidade de dinossauros e a relação funcionário/dinossauro para cada área:");
		System.out.println("AREA, QTD_FUNCIONARIOS, QTD_DINOS, RELACAO");
		while (rs.next()) {			
			String area = rs.getString("area");		
			int qtdFuncionarios = rs.getInt("qtd_funcionarios");
			int qtdDinos = rs.getInt("qtd_dinos");
			double relacao = rs.getDouble("relacao");
			System.out.println(area + ", " + qtdFuncionarios + ", " + qtdDinos  + ", " + relacao);
		}
		
		statement.close();
		rs.close();
	}
		
	
	
	//-----------------------------------------CONSULTAS C-----------------------------------------
	//--C1) Retorna quantidade de veículos por ano
	public static void consultaC1(Connection connection) throws SQLException {
		String sql = "SELECT veiculo.ano ANO, COUNT(veiculo.ano) FROTA " +
				 "FROM tb_veiculos veiculo " + 
				 "GROUP BY veiculo.ano " +
				 "ORDER BY ANO";
		Statement statement = connection.createStatement();
		ResultSet rs = statement.executeQuery(sql);
		
		System.out.println("\n\nConsulta c1) Retorna quantidade de veículos por ano:");
		System.out.println("ANO, FROTA");
		while (rs.next()) {					
			int ano = rs.getInt("ano");
			int frota = rs.getInt("frota");
			System.out.println(ano + ", " + frota);
		}
		
		statement.close();
		rs.close();
	}
	
	
	//--C2) Retorna a media salarial dos funcionários por área
	public static void consultaC2(Connection connection) throws SQLException {
		String sql = "SELECT area.nomearea AREA, ROUND(AVG(func.multipsal*funcao.salariobase),2) MEDIA_SALARIAL " +
				 "FROM tb_funcoes funcao " + 
				 	"INNER JOIN tb_funcionarios func ON funcao.id_funcao = func.id_funcao " +
				 	"INNER JOIN tb_areas area ON func.id_area = area.id_area " +
				 "GROUP BY area.nomearea " +
				 "ORDER BY MEDIA_SALARIAL";
		Statement statement = connection.createStatement();
		ResultSet rs = statement.executeQuery(sql);
		
		System.out.println("\n\nConsulta c2) Retorna a media salarial dos funcionários por área:");
		System.out.println("AREA, MEDIA_SALARIAL");
		while (rs.next()) {					
			String area = rs.getString("area");
			double mediaSalarial = rs.getDouble("media_salarial");
			System.out.println(area + ", " + mediaSalarial);
		}
		
		statement.close();
		rs.close();
	}
	
	
	//--C3) Status da capacidade de transporte da frota
	public static void consultaC3(Connection connection) throws SQLException {
		String sql = "SELECT vec.status STATUS, SUM(vec.cargamax) CAPACIDADE_TRANSPORTE " +
				 "FROM tb_veiculos vec " + 
				 "GROUP BY vec.status";
		Statement statement = connection.createStatement();
		ResultSet rs = statement.executeQuery(sql);
		
		System.out.println("\n\nConsulta c3) Status da capacidade de transporte da frota:");
		System.out.println("STATUS, CAPACIDADE_TRANSPORTE");
		while (rs.next()) {					
			String status = rs.getString("status");
			int capacidadeTransporte = rs.getInt("capacidade_transporte");
			System.out.println(status + ", " + capacidadeTransporte +" toneladas");
		}
		
		statement.close();
		rs.close();
	}
	
	
	//--C4) Mostra as areas em que o menor salário é ao menos 6000
	public static void consultaC4(Connection connection) throws SQLException {
		String sql = "SELECT area.nomearea AREA, MIN(func.multipsal*funcao.salariobase) MENOR_SALARIO " +
				 "FROM tb_funcoes funcao " + 
				 	"INNER JOIN tb_funcionarios func ON funcao.id_funcao = func.id_funcao " +
				 	"INNER JOIN tb_areas area ON func.id_area = area.id_area " +
				 "GROUP BY area.nomearea " +
				 "HAVING MIN(func.multipsal*funcao.salariobase) >= 6000 " + 
				 "ORDER BY MENOR_SALARIO";
		Statement statement = connection.createStatement();
		ResultSet rs = statement.executeQuery(sql);
		
		System.out.println("\n\nConsulta c4) Mostra as areas em que o menor salário é ao menos 6000:");
		System.out.println("AREA, MENOR_SALARIO");
		while (rs.next()) {					
			String area = rs.getString("area");
			double menorSalario = rs.getDouble("menor_salario");
			System.out.println(area + ", " + menorSalario);
		}
		
		statement.close();
		rs.close();
	}
	
	
	//--C5) Mostra as áreas que tiverem eventos e somaram menos de 500 pessoas de público em eventos no último mês
	public static void consultaC5(Connection connection) throws SQLException {
		String sql = "SELECT area.nomearea AREA, SUM(qtdpublico) PUBLICO_MES " +
				 "FROM tb_areas area INNER JOIN tb_areasatracoes aa " + 
				 	"ON area.id_area = aa.id_area " +
				 "WHERE aa.datahoraevento BETWEEN SYSDATE - 30 AND SYSDATE " +
				 "GROUP BY area.nomearea " +
				 "HAVING (SUM(qtdpublico) < 500) " + 
				 "ORDER BY PUBLICO_MES";
		Statement statement = connection.createStatement();
		ResultSet rs = statement.executeQuery(sql);
		
		System.out.println("\n\nConsulta c5) Mostra as áreas que tiverem eventos e somaram menos de 500 pessoas de público em eventos no último mês:");
		System.out.println("AREA, PUBLICO_MES");
		while (rs.next()) {					
			String area = rs.getString("area");
			int publicoMes = rs.getInt("publico_mes");
			System.out.println(area + ", " + publicoMes);
		}
		
		statement.close();
		rs.close();
	}
	
	
		
	//-----------------------------------------CONSULTAS D-----------------------------------------
	//--D1) Nome e altura dos dinossauros que habitam areas maiores de 5000m2
	public static void consultaD1(Connection connection) throws SQLException {
		String sql = "SELECT dino.nome NOME, dino.altura ALTURA " +
				 "FROM tb_dinossauros dino " + 
				 "WHERE dino.id_dino IN " +
				 	"(SELECT dino2.id_dino " +
				 	"FROM tb_dinossauros dino2 INNER JOIN tb_areas area ON dino2.id_area = area.id_area " +
				 	"WHERE area.metragem > 5000)";
		Statement statement = connection.createStatement();
		ResultSet rs = statement.executeQuery(sql);
		
		System.out.println("\n\nConsulta d1) Nome e altura dos dinossauros que habitam areas maiores de 5000m2:");
		System.out.println("NOME, ALTURA");
		while (rs.next()) {					
			String nome = rs.getString("nome");
			double altura = rs.getDouble("altura");
			System.out.println(nome + ", " + altura);
		}
		
		statement.close();
		rs.close();
	}
	
	
	//--D2) Nome e sexo dos funcionários que trabalham em terreno arenoso
	public static void consultaD2(Connection connection) throws SQLException {
		String sql = "SELECT func.nome NOME, func.sexo SEXO " +
				 "FROM tb_funcionarios func " + 
				 "WHERE func.id_funcionario IN " +
				 	"(SELECT func2.id_funcionario " +
				 	"FROM tb_funcionarios func2 INNER JOIN tb_areas area ON func2.id_area = area.id_area " +
				 	"WHERE area.tipoterreno LIKE 'Arenoso')";
		Statement statement = connection.createStatement();
		ResultSet rs = statement.executeQuery(sql);
		
		System.out.println("\n\nConsulta d2) Nome e sexo dos funcionários que trabalham em terreno arenoso:");
		System.out.println("NOME, SEXO");
		while (rs.next()) {					
			String nome = rs.getString("nome");
			String sexo = rs.getString("sexo");
			System.out.println(nome + ", " + sexo);
		}
		
		statement.close();
		rs.close();
	}
	
	
	//--D3) Mostra funcionarios que trabalham no Sul
	public static void consultaD3(Connection connection) throws SQLException {
		String sql = "SELECT func.nome NOME, area.setor SETOR " +
				 "FROM tb_funcionarios func INNER JOIN tb_areas area ON func.id_area = area.id_area " + 
				 "WHERE area.id_area IN " +
				 	"(SELECT area2.id_area " +
				 	"FROM tb_areas area2 " +
				 	"WHERE area.setor LIKE 'S')";
		Statement statement = connection.createStatement();
		ResultSet rs = statement.executeQuery(sql);
		
		System.out.println("\n\nConsulta d3) Mostra funcionarios que trabalham no Sul:");
		System.out.println("NOME, SETOR");
		while (rs.next()) {					
			String nome = rs.getString("nome");
			String setor = rs.getString("setor");
			System.out.println(nome + ", " + setor);
		}
		
		statement.close();
		rs.close();
	}
	
	
	//--D4) Mostra funções que trabalham no coberto e as áreas 
	public static void consultaD4(Connection connection) throws SQLException {
		String sql = "SELECT DISTINCT funcao.funcao FUNCAO, area.nomearea AREA " +
				 "FROM tb_funcoes funcao " + 
				 	"INNER JOIN tb_funcionarios func ON funcao.id_funcao = func.id_funcao " + 
				 	"INNER JOIN tb_areas area ON func.id_area = area.id_area " + 
				 "WHERE area.id_area IN " +
				 	"(SELECT area2.id_area " +
				 	"FROM tb_areas area2 " +
				 	"WHERE coberta LIKE 'S') " +
				 	"ORDER BY FUNCAO";
		Statement statement = connection.createStatement();
		ResultSet rs = statement.executeQuery(sql);
		
		System.out.println("\n\nConsulta d4) Mostra funções que trabalham no coberto e as áreas:");
		System.out.println("FUNCAO, AREA");
		while (rs.next()) {					
			String funcao = rs.getString("funcao");
			String area = rs.getString("area");
			System.out.println(funcao + ", " + area);
		}
		
		statement.close();
		rs.close();
	}
	
	
	//--D5) Mostra cada funcionário, e sua função, que tem fator multiplicativo maior que 1.5 e salário base maior que 5000
	public static void consultaD5(Connection connection) throws SQLException {
		String sql = "SELECT func.nome NOME, funcao.funcao FUNCAO " +
				 "FROM tb_funcionarios func INNER JOIN tb_funcoes funcao " + 
				 	"ON func.id_funcao = funcao.id_funcao " + 
				 "WHERE func.multipsal > 1.5 AND funcao.id_funcao NOT IN " +
				 	"(SELECT funcao2.id_funcao " +
				 	"FROM tb_funcoes funcao2 " +
				 	"WHERE funcao2.salariobase <= 5000)";
		Statement statement = connection.createStatement();
		ResultSet rs = statement.executeQuery(sql);
		
		System.out.println("\n\nConsulta d5) Mostra cada funcionário, e sua função, que tem fator multiplicativo maior que 1.5 e salário base maior que 5000:");
		System.out.println("NOME, FUNCAO");
		while (rs.next()) {					
			String nome = rs.getString("nome");
			String funcao = rs.getString("funcao");
			System.out.println(nome + ", " + funcao);
		}
		
		statement.close();
		rs.close();
	}
	
	
}
	
