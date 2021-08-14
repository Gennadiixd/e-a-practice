import { ApolloServer } from 'apollo-server';
import { makeExecutableSchema } from 'graphql-tools';
import { readFileSync } from 'fs';
import * as path from 'path';
import { resolvers } from './resolvers';
import { createContext } from './context';

const typeDefs = readFileSync(
  path.resolve(__dirname, 'schemas', 'typeDefs.graphql'),
  'utf-8',
);

const schema = makeExecutableSchema({
  typeDefs,
  resolvers,
});

new ApolloServer({ schema, context: createContext })
  .listen({ port: 5000 })
  .then(() =>
    console.log('🚀 Server ready at: http://localhost:5000 ⭐️⭐️⭐️⭐️'),
  );
