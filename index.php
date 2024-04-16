<?php

// Carrega configurações globais
require("_global.php");

// Configurações desta página
$page = array(
    "title" => $site['slogan'], // Título desta página
    "css" => "index.css", // Folha de estilos desta página
);

/**
 * Listar os artigos do banco de dados
 * Regras / parâmetros:
 *  • Ordenados pela data de publicação com os mais recentes primeiro
 *  • Obter somente artigos no passado e presente
 *      • Não obter artigos agendados para o futuro
 *  • Obter somente artigos com status = 'on'
 *  • Obter os campos id, thumbnail, title, summary
 **/
$sql = <<<SQL

SELECT
-- Obter o id
	art_id
FROM article

-- Obter somente artigos no passado e presente
-- Não obter artigos agendados para o futuro
	WHERE art_date <= NOW()	  	
        
-- Obter somente artigos com status = 'on'
		AND art_status = 'on'        	

-- Ordenados pela data de publicação com os mais recentes primeiro
	ORDER BY art_date DESC
    limit 3;

SQL;

//  Executa o SQL e armazena os resultados em $res
$res = $conn->query($sql);

// Conta os registros e armazena em $total
$total = $res->num_rows;

// Variável que contém a lista de artigos em HTML e título
$articles = '';

// Se não tem artigos, exibe um aviso
if ($total == 0) :
    $articles = "<h2>Artigos recentes</h2><p>Não achei nada!</p>";
else :

    // Título
    if ($total == 1) $articles = '<h2>Artigo mais recente</h2>';
    else $articles = "<h2>{$total} artigos mais recentes</h2>";

    // Loop para obter cada artigo
    while ($art = $res->fetch_assoc())

        // Chama a função que gera a lista de artigos
        $articles .= view_article($art['art_id']);

endif;

// Inclui o cabeçalho do documento
require('_header.php');
?>

<article>
     <!-- Conteúdo inútil só para testes visuais -->
    <h2>A Jornada da Inovação: A Evolução da Tecnologia ao Longo dos Séculos</h2> 
    <p>A evolução da tecnologia é uma jornada fascinante que atravessa séculos de inovação e descoberta. Desde os primórdios da civilização humana, os seres humanos têm buscado maneiras de simplificar tarefas, aumentar a eficiência e melhorar a qualidade de vida por meio da tecnologia.</p>
    <p>No início, as ferramentas mais básicas, como pedras afiadas e paus, eram usadas para caçar e se proteger. Com o tempo, surgiram avanços como a roda e a agricultura, que revolucionaram a maneira como vivemos e interagimos com o mundo ao nosso redor.</p>
    <p> No entanto, foi a Revolução Industrial que realmente marcou o início de uma era de inovação tecnológica sem precedentes. A introdução de máquinas a vapor, locomotivas e fábricas automatizadas transformou completamente a maneira como produzimos bens e nos deslocamos.</p>
    <img src="assets/img/imageindex.png" alt="Evolução dos computadores">    
    <p>No século XX, testemunhamos avanços incríveis em diversas áreas, desde a eletrônica até a computação e a biotecnologia. A invenção do rádio, televisão e telefone trouxe o mundo para nossas casas, enquanto os computadores pessoais e a internet revolucionaram a maneira como compartilhamos informações e nos comunicamos.</p>
    <p>Hoje, estamos na era da tecnologia digital, onde a computação em nuvem, inteligência artificial e dispositivos conectados estão moldando o mundo ao nosso redor de maneiras inimagináveis. Desde smartphones que cabem no bolso até carros autônomos e assistentes virtuais inteligentes, a tecnologia está se tornando cada vez mais integrada em todos os aspectos de nossas vidas.</p>
    <p>No entanto, com todos esses avanços, também enfrentamos desafios significativos, como questões de privacidade, segurança cibernética e desigualdade digital. À medida que continuamos avançando, é crucial que consideremos não apenas os benefícios da tecnologia, mas também suas ramificações sociais, éticas e ambientais.</p>
    <p>Em última análise, a evolução da tecnologia é uma história de progresso e potencial. À medida que exploramos novas fronteiras e desafiamos os limites do que é possível, é importante lembrar que somos os criadores de nosso próprio futuro e que cabe a nós utilizar a tecnologia de maneira responsável e para o bem maior da humanidade.</p>

</article>                

<aside>
<?php echo $articles ?>

<?php

    // Mostra os artigos mais visualizados
    require('widgets/_mostviewed.php'); 
    ?>

</aside>

<?php require('_footer.php'); ?>