/*
  Warnings:

  - You are about to drop the column `salt` on the `doctor` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `doctor` DROP COLUMN `salt`;
ALTER TABLE `patient` DROP COLUMN `salt`;
