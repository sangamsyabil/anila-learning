
// Collect unique types
const types = [];
pokedex.forEach(pokemon => {
  pokemon.type.forEach(type => {
    if (!types.includes(type)) {
      types.push(type);
    }
  });
});

const typeInfo = {};

// Initialize typeInfo object with default values
types.forEach(type => {
  typeInfo[type] = {
    totalPokemon: 0,
    totalHP: 0,
    totalAttack: 0
  };
});

// Calculate totals for each type
pokedex.forEach(pokemon => {
  pokemon.type.forEach(type => {
    typeInfo[type].totalPokemon += 1;
    typeInfo[type].totalHP += pokemon.base.HP;
    typeInfo[type].totalAttack += pokemon.base.Attack;
  });
});

const navBar = document.getElementById('navBar');

// Create sections for each type
types.forEach(type => {
  const _section = document.createElement('div');
  _section.id = type.toLowerCase(); // Use lower case for section IDs
  _section.innerHTML = `<h3>Type: ${type} (${typeInfo[type].totalPokemon})</h3>
    <p>Total HP: ${typeInfo[type].totalHP} | Total Attack: ${typeInfo[type].totalAttack}</p>
    <p><a href="#top">Back to top</a></p>`;
  document.getElementById('info-section').appendChild(_section);

  // Create navigation links
  const _link = document.createElement('a');
  _link.href = `#${type.toLowerCase()}`;
  _link.textContent = type;
  _link.addEventListener('click', () => {
    document.getElementById(type.toLowerCase()).scrollIntoView({ behavior: 'smooth' });
  });
  navBar.appendChild(_link);
});

// Display Pokémon by type
types.forEach(type => {
  const typePokemons = pokedex.filter(pokemon => pokemon.type.includes(type));
  typePokemons.sort((a, b) => (a.name > b.name ? 1 : -1)); // Sort alphabetically by name

  const section = document.getElementById(type.toLowerCase());
  const pokemonContainer = document.createElement('div');
  pokemonContainer.classList.add('pokemon-container');

  typePokemons.forEach(pokemon => {
    const pokemonElement = document.createElement('div');
    pokemonElement.classList.add('pokemon');
    pokemonElement.innerHTML = `
      <a href="${pokemon.url}" target="_blank">
        <h2>${pokemon.name}</h2>
        <div class="pokemon-image">
          <img src="${pokemon.sprite}" alt="${pokemon.name}">
        </div>
        <div id="item-info">
          <div>HP: <span>${pokemon.base.HP}</span></div>
          <div>Defense: <span>${pokemon.base.Defense}</span></div>
          <div>Sp. Defense: <span>${pokemon.base["Sp. Attack"]}</span></div>
          <div>Attack: <span>${pokemon.base.Attack}</span></div>
          <div>Sp. Attack: <span>${pokemon.base["Sp. Attack"]}</span></div>
          <div>Speed: <span>${pokemon.base.Speed}</span></div>
        </div>
      </a>`;
    pokemonContainer.appendChild(pokemonElement);
  });

  section.appendChild(pokemonContainer);
});
