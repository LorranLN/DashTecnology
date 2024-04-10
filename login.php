<?php

// Carrega configurações globais
require("_global.php");
$feedback = '';
if (isset($_POST['email']) and isset($_POST['password'])) {

    $sql = "select * from employee where emp_email= '{$_POST['email']}' and emp_password=SHA1 ('{$_POST['password']}')";
    $res = $conn->query($sql);
    if ($res->num_rows == 1) {

        $row = $res->fetch_assoc();
        setcookie('user', serialize($row));
        $feedback = 'logado';
    } else {
        $feedback = 'error';
    }
}





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
    <?php if ($feedback == 'logado') { ?>
        <div>usuário logado com sucesso</div>
    <?php } else { ?>
        <form action="" method="post">
            <?php if ($feedback == 'error') { ?>
                <div>erro:usuário ou senha não encontrados</div>
            <?php } ?>
            <p> <label for="email">email:</label>
                <input type="email" name="email" id="email">
            </p>
            <p> <label for="password">senha:</label>
                <input type="password" name="password" id="password">
            </p>
            <p> <button type="submit">Entrar</button></p>
        </form>
    <?php } ?>
</article>

<aside></aside>

<?php
// Inclui o rodapé do documento
require('_footer.php');
?>