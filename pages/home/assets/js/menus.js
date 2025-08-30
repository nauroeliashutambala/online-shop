function add_itens_menu(conteudo, iconeClasse, url) {
    document.querySelector(".menu").innerHTML += `
        <a href="${url}" class="item">
            <i class="${iconeClasse}"></i>
            <div>${conteudo}</div>
        </a>
    `;
}

function add_itens_nav_menu(conteudo, url) {
    document.querySelector(".lista_menu").innerHTML += `
        <li><a href="${url}">${conteudo}</a></li>
    `;
}

// Menu de navegação superior
add_itens_nav_menu("Inicio", "#");
add_itens_nav_menu("Reservas", "#");
add_itens_nav_menu("Pendentes", "#");
add_itens_nav_menu("Login", "#");

// Menu lateral com ícones
add_itens_menu("Inicio", "fas fa-home", "#");
add_itens_menu("E-books", "fas fa-book", "#");
add_itens_menu("Vender", "fas fa-dollar-sign", "#");
add_itens_menu("Painel", "fas fa-cog", "#"); 
add_itens_menu("Painel", "fas fa-cog", "#");
add_itens_menu("Login", "fas fa-sign-in-alt", "#"); 
add_itens_menu("Sair", "fas fa-sign-out-alt", "#"); 


// Função de abrir/fechar menu
function abrir_menu() {
    document.querySelector(".menu").classList.toggle("open");
}

// Opcional: ligar click do botão
