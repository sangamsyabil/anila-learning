// Retrieve every type of bean and return unique values
function getUniqueBeans(counters) {
    const uniqueBeans = [];
    for (const counter of counters) {
        if (!uniqueBeans.includes(counter.bean)) {
            uniqueBeans.push(counter.bean);
        }
    }
    return uniqueBeans;
}

//  Sort the counters data by counter names
function sortCountersByName(counters) {
    return counters.slice().sort((a, b) => {
        if (a.name < b.name) return -1;
        if (a.name > b.name) return 1;
        return 0;
    });
}

// Filter counters by bean type
function filterCountersByBeanType(counters, beanType) {
    return counters.filter(counter => counter.bean === beanType);
}

// Calculate total number of beans counted
function getTotalBeanCount(counters) {
    return counters.reduce((total, counter) => total + counter.count, 0);
}

// Variables
const uniqueBeans = getUniqueBeans(counters);
const beanListsContainer = document.getElementById("beanLists");

// Dynamically create ordered lists in HTML
for (const beanType of uniqueBeans) {
    const beanCounters = filterCountersByBeanType(counters, beanType);
    const totalBeanCount = getTotalBeanCount(beanCounters);

    // Sort the beanCounters array by name
    sortedBeanCounters = sortCountersByName(beanCounters)

    const list = document.createElement("ol");
    list.innerHTML = `<h3>${beanType} (${totalBeanCount})</h3>`;

    for (const counter of sortedBeanCounters) {
        const listItem = document.createElement("li");
        listItem.textContent = `${counter.name} (${counter.count})`;
        list.appendChild(listItem);
    }

    beanListsContainer.appendChild(list);
}
