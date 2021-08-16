import { PrismaClient } from '@prisma/client';
import { Resolvers } from '../generated/resolver-types';
import { Query } from './query';
import {Mutation} from './mutation';

export const resolvers: Resolvers<{ prisma: PrismaClient }> = {
  Query,
  Mutation
};
