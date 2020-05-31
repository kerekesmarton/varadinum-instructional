module.exports.paginateResults = ({
  after: cursor,
  pageSize = 20,
  results,
  // can pass in a function to calculate an item's cursor
  getCursor = () => null,
}) => {
  if (pageSize < 1) return [];

  if (!cursor) return results.slice(0, pageSize);
  const cursorIndex = results.findIndex(item => {
    // if an item has a `cursor` on it, use that, otherwise try to generate one
    let itemCursor = item.cursor ? item.cursor : getCursor(item);

    // if there's still not a cursor, return false by default
    return itemCursor ? cursor === itemCursor : false;
  });

  return cursorIndex >= 0
    ? cursorIndex === results.length - 1 // don't let us overflow
      ? []
      : results.slice(
          cursorIndex + 1,
          Math.min(results.length, cursorIndex + 1 + pageSize),
        )
    : results.slice(0, pageSize);
};

//module.exports.creteAccountsServer = () => {
//  
//  mongoose.connect('mongodb://localhost:27017/instructional-mongoose', {
//    useNewUrlParser: true,
//    useUnifiedTopology: true,
//  });
//  
//  const accountsMongo = new Mongo(mongoose.connection);
//
//  const accountsPassword = new AccountsPassword({
//    // You can customise the behavior of the password service by providing some options
//  });
//
//  const accountsServer = new AccountsServer(
//    {
//      // We link the mongo adapter we created in the previous step to the server
//      db: accountsMongo,
//      // Replace this value with a strong random secret
//      tokenSecret: 'my-super-random-secret',
//    },
//    {
//      // We pass a list of services to the server, in this example we just use the password service
//      password: accountsPassword,
//    }
//  );
//  
//  return { accountsServer }
//};
