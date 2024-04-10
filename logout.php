<?php

// Carrega configurações globais
require("_global.php");


// Defina o nome do cookie que deseja apagar
$cookie_name = 'user';

// Defina um tempo de expiração no passado (por exemplo, uma hora atrás)
$expiration_time = time() - 3600;

// Defina o cookie com o valor vazio ('') e o tempo de expiração no passado
setcookie($cookie_name, '', $expiration_time, '/');

// Também é uma boa prática limpar a variável global $_COOKIE para o cookie apagado
unset($_COOKIE[$cookie_name]);

 header('Location:index.php');



// Configurações desta página
$page = array(
    "title" => "Lendo e Entendendo", // Título desta página
    "css" => "index.css",            // Folha de estilos desta página
    "js" => "index.js",              // JavaScript desta página
);

// Inclui o cabeçalho do documento
require('_header.php');
?>

<article></article>

<aside></aside>

<?php
// Inclui o rodapé do documento
require('_footer.php');
?>