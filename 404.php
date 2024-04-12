<?php

// Carrega configurações globais
require("_global.php");

// Configurações desta página
$page = array(
    "title" => "Lendo e Entendendo", // Título desta página
    "css" => "index.css",            // Folha de estilos desta página
    "js" => "index.js",              // JavaScript desta página
);

// Inclui o cabeçalho do documento
require('_header.php');
?>

<article>
    <div class="errorpage">
        <img src="/assets/img/images.png" alt="Página indisponivel" class="images">
    </div>
    <h2>Está pagina está <span class="destaque">indisponivel</span>, tente ir para a <span class="home">página principal</span> </h2>

</article>

<aside>
    <?php
// Mostra os artigos mais visualizados
    require('widgets/_mostviewed.php');
    ?>
    </aside>

<?php
// Inclui o rodapé do documento
require('_footer.php');
?>