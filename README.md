Хранение и отслеживание stakeId должно не должно быть в блокчейне, тем самым мы снижаем стоимость использования контракта, но делаем его менее децентрализованным.

Для тестов нужно больше времени. Конкретные вопросы которые у меня возникли(не могу найти эквивалент ethers.getContractFacctory & ethers.getSigner)

С деплоем тоже возникла проблема, нужен рабочий кран для тестнета. Кран на тронлинке работает через твиттер, я все сделал по инструкции, но тесткоины еще не пришли

Корректность работы контракта пришлось проверять через TronIde

Инструменты которые я использовал: tronbox, tronweb, openzeppelin, mocha, chai, solidity-coverage.