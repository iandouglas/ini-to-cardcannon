const fs = require('fs');
const helpers = require('./helpers.js')
console.log('app.js running!')

module.exports = app => {

  app.log("up and running");

  app.on('issues.opened', async context => {
    // app.log("i have new issues");
    const issueTitle = context.payload.issue.title
    // app.log(issueTitle);

    const triggerPattern = /^bootstrap ([a-zA-Z0-9-_])/gi;
    if triggerPattern.test(issueTitle) {
      project = issueTitle.replace(triggerPattern, '$1');

      var newIssues = []

      app.log('bootstrap running...')

      //move bootstrap issue into progress
      const updateIssue = context.repo({
        number: context.payload.issue.number,
        title: 'bootstrap '+project+' in progress',
        labels: ['in progress']
      })
      context.github.issues.edit(updateIssue)

      //get card data from config
      const cardData = await getCardData(project)
      app.log("card data:");
      app.log(cardData);

//       //create cards in reverse order for proper order on waffle.io board
      const newIssues = await createCards(project, context, cardData.reverse())
      app.log("issues created:");
      app.log(newIssues);

//       //update cards with epic and dependency relationships
      await updateCardRelationships(project, context, cardData, newIssues)

      //close bootstrap issue
      const closeIssue = context.repo({
        number: context.payload.issue.number,
        state: 'closed'
      })
      context.github.issues.edit(closeIssue)
    }
  })
}

async function getCardData(project) {
  const cardsData = await helpers.readFilePromise('./_output/'+project+'/cards.json')
  const cardsJSON = JSON.parse(cardsData)
  return cardsJSON
}

async function createCards(project, context, cardData) {
  let newIssues = []

  for (const card of cardData) {
    const response = await (createIssue(context, card))
    newIssues.push({id: card.id, issueNumber: response.data.number})
  }

  return newIssues
}

async function updateCardRelationships(context, cardData, newIssues) {

  for (const card of cardData) {
    console.log('updaterelationship, card.id: ' + card.id)
    const newIssue = newIssues.find(issue => issue.id === card.id)
    console.log('card.id: ' + card.id + ' was given issue.id: ' + newIssue.issueNumber)

    if(card.childOf) {
      console.log('card.id: ' + card.id + ' reports to be a child of card.id ' + card.childOf);
      const parentIssue = newIssues.find(issue => issue.id === card.childOf)
      console.log('card.id: ' + card.id + ' has parent card.id: ' + card.childOf + ' whose issue.id is ' + parentIssue.issueNumber)
      let issue = await getIssue(context, newIssue.issueNumber)
      const newBody = issue.data.body + '\n\nchild of #' + parentIssue.issueNumber
      await editIssue(context, newIssue.issueNumber, newBody)
      await sleep(1250);
    }

    if(card.dependsOn) {
      for (const dependencyId of card.dependsOn) {
        const dependencyIssue = newIssues.find(issue => issue.id === dependencyId)
        console.log('card.id: ' + card.id + ' has dependency on card.id: ' + dependencyId + ' whose issue.id is ' + dependencyIssue.issueNumber)
        let issue = await getIssue(context, newIssue.issueNumber)
        const newBody = issue.data.body + '\n\ndepends on #' + dependencyIssue.issueNumber
        await editIssue(context, newIssue.issueNumber, newBody)
        await sleep(1250);
      }
    }
  }
}

async function getIssue(context, issueNumber) {

  const issue = context.repo({
    number: issueNumber
  })
  const response = await context.github.issues.get(issue)
  return response
  console.log(response)
}

async function createIssue(project, context, cardData) {
  const cardContentData = await helpers.readFilePromise('./_output/'+project+'/cards/' + cardData.id + '.md')

  const newIssue = context.repo({
    title: cardData.title,
    labels: cardData.labels,
    body: cardContentData
  })
  const response = await context.github.issues.create(newIssue)
  await sleep(5000);
  return response
}

async function editIssue(context, issueNumber, body) {

  const newIssue = context.repo({
    number: issueNumber,
    body: body
  })
  const response = await context.github.issues.edit(newIssue)
  await sleep(500);
  return response
}

function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}
