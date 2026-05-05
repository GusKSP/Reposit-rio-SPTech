
function Somar(numero1, numero2) {
    numero1 = Number(numero1);
    numero2 = Number(numero2);
    if (numero1 == null || numero1 == "" || numero1 == undefined) {
        console.log("Parâmetro numero1 não pode ser nulo ou indefinido");
        return "Parâmetro numero1 não pode ser nulo ou indefinido";
    }
    if (numero2 == null || numero2 == "" || numero2 == undefined) {
        console.log("Parâmetro numero2 não pode ser nulo ou indefinido");
        return "Parâmetro numero2 não pode ser nulo ou indefinido";
    }
    if (isNaN(numero1)) {
        console.log("tipo inválido para o argumento numero1");
        return "tipo inválido para o argumento numero1";
    }
    if (isNaN(numero2)) {
        console.log("tipo inválido para o argumento numero2");
        return "tipo inválido para o argumento numero2";
    }
    return numero1 + numero2;
}

function calcularDistancia(x1, y1, x2, y2) {
    x1 = Number(x1);
    y1 = Number(y1);
    x2 = Number(x2);
    y2 = Number(y2);
    if (x1 == null || x1 == "" || x1 == undefined) {
        console.log("Parâmetro x1 não pode ser nulo ou indefinido");
        return "Parâmetro x1 não pode ser nulo ou indefinido";
    }
    if (y1 == null || y1 == "" || y1 == undefined) {
        console.log("Parâmetro y1 não pode ser nulo ou indefinido");
        return "Parâmetro y1 não pode ser nulo ou indefinido";
    }
    if (x2 == null || x2 == "" || x2 == undefined) {
        console.log("Parâmetro x2 não pode ser nulo ou indefinido");
        return "Parâmetro x2 não pode ser nulo ou indefinido";
    }
    if (y2 == null || y2 == "" || y2 == undefined) {
        console.log("Parâmetro y2 não pode ser nulo ou indefinido");
        return "Parâmetro y2 não pode ser nulo ou indefinido";
    }
    if (isNaN(x1)) {
        console.log("tipo inválido para o argumento x1");
        return "tipo inválido para o argumento x1";
    }
    if (isNaN(y1)) {
        console.log("tipo inválido para o argumento y1");
        return "tipo inválido para o argumento y1";
    }
    if (isNaN(x2)) {
        console.log("tipo inválido para o argumento x2");
        return "tipo inválido para o argumento x2";
    }
    if (isNaN(y2)) {
        console.log("tipo inválido para o argumento y2");
        return "tipo inválido para o argumento y2";
    }
    return ((x2 - x1) ** 2 + (y2 - y1) ** 2) ** 0.5;
}

function converterParaHoraMinutoSegundo(numero) {
    numero = Number(numero);
    if (numero == null || numero == "" || numero == undefined) {
        console.log("Parâmetro numero não pode ser nulo ou indefinido");
        return "Parâmetro numero não pode ser nulo ou indefinido";
    }
    if (isNaN(numero)) {
        console.log("tipo inválido para o argumento numero");
        return "tipo inválido para o argumento numero";
    }
    let horas = Math.floor(numero / 3600);
    let minutos = Math.floor((numero % 3600) / 60);
    let segundos = numero % 60;
    return horas + ":" + minutos + ":" + segundos;
}

function ePrimo(numero) {
    numero = Number(numero);
    if (numero == null || numero == "" || numero == undefined) {
        console.log("Parâmetro numero não pode ser nulo ou indefinido");
        return "Parâmetro numero não pode ser nulo ou indefinido";
    }
    if (isNaN(numero)) {
        console.log("tipo inválido para o argumento numero");
        return "tipo inválido para o argumento numero";
    }
    for (let i = 2; i < numero; i++) {
        if (numero % i === 0) {
            return false;
        }
    }
    return true;
}

function calcularFatorial(numero) {
    numero = Number(numero);
    if (numero == null || numero == "" || numero == undefined) {
        console.log("Parâmetro numero não pode ser nulo ou indefinido");
        return "Parâmetro numero não pode ser nulo ou indefinido";
    }
    if (isNaN(numero)) {
        console.log("tipo inválido para o argumento numero");
        return "tipo inválido para o argumento numero";
    }
    for (let i = numero; i > 1; i--) {
        numero *= i - 1;
    }
    return numero;
}

// 1.6 Calcular média
// Nome: calcularMedia
// Recebe um parâmetro vetor. 
// Valida se o parâmetro é null ou undefined e caso seja:
// Escreva no console "Parâmetro X não pode ser nulo ou indefinido" - Onde X é o nome do parâmetro.
// Interrompa a execução da função.
// Valida o tipo do parâmetro != number e caso seja:
// Escreva no console "tipo inválido para o argumento X" - Onde X é nome do parâmetro.
// Interrompa a execução da função.
// Dica: utilize o typeof - Exemplo: typeof numero1 == "number"
// Calcula a média aritmética entre todos os valores númericos contidos no vetor

function calcularMedia(vetor) {
    if (vetor == null || vetor == undefined) {
        console.log("Parâmetro vetor não pode ser nulo ou indefinido");
        return "Parâmetro vetor não pode ser nulo ou indefinido";
    }
    let soma = 0;
    for (let i = 0; i < vetor.length; i++) {
        vetor[i] = Number(vetor[i]);
        if (isNaN(vetor[i])) {
            console.log("tipo inválido para o argumento vetor");
            return "tipo inválido para o argumento vetor";
        }
        else {
            soma += vetor[i];
        }
    }
    media = soma / vetor.length;
    return media;
}


// 1.7 Calcular média ponderada
// Nome: calcularMediaPonderada
// Recebe 2 parâmetros vetorMedias e vetorPesos. 
// Valida se nenhum dos parâmetros é null ou undefined e caso seja:
// Escreva no console "Parâmetro X não pode ser nulo ou indefinido" - Onde X é o nome do parâmetro.
// Interrompa a execução da função.
// Valida o tipo dos parâmetros caso != number e caso seja:
// Escreva no console "tipo inválido para o argumento X" - Onde X é nome do parâmetro.
// Interrompa a execução da função.
// Dica: utilize o typeof - Exemplo: typeof numero1 == "number"
// Valida que a soma de todos os pesos seja 1 e caso não seja:
// Escreva no console "A soma dos pesos deve ser 1"
// Calcula a média ponderada entre todos os valores númericos contidos no vetor utilizando os pesos do vetorPesos.
// Exemplo: notas: [10.0, 9.5] pesos: [0.8, 0.2] = 10 * 0.8 + 9.5 * 0.2 = 9.9

function calcularMediaPonderada(vetorMedias, vetorPesos) {
    if (vetorMedias == null || vetorMedias == undefined || vetorMedias == "") {
        console.log("Parâmetro vetorMedias não pode ser nulo ou indefinido");
        return "Parâmetro vetorMedias não pode ser nulo ou indefinido";
    }
    if (vetorPesos == null || vetorPesos == undefined || vetorPesos == "") {
        console.log("Parâmetro vetorPesos não pode ser nulo ou indefinido");
        return "Parâmetro vetorPesos não pode ser nulo ou indefinido";
    }
    let somaPesos = 0;
    for (let i = 0; i < vetorMedias.length; i++) {
        vetorMedias[i] = Number(vetorMedias[i]);
        vetorPesos[i] = Number(vetorPesos[i]);
        if (isNaN(vetorMedias[i])) {
            console.log("tipo inválido para o argumento vetorMedias");
            return "tipo inválido para o argumento vetorMedias";
        }
        if (isNaN(vetorPesos[i])) {
            console.log("tipo inválido para o argumento vetorPesos");
            return "tipo inválido para o argumento vetorPesos";
        }
        somaPesos += vetorPesos[i];
    }
    if (somaPesos !== 1) {
        console.log("A soma dos pesos deve ser 1");
        return "A soma dos pesos deve ser 1";
    }
    let mediaPonderada = 0;
    for (let i = 0; i < vetorMedias.length; i++) {
        mediaPonderada += vetorMedias[i] * vetorPesos[i];
    }
    return mediaPonderada;
}