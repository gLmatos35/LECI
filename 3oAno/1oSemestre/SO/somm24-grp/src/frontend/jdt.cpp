/*
 *  \author Artur Pereira (artur at ua dot pt)
 */

#include "jdt.h"
#include "tam.h"
#include "binselection.h"

#include <stdio.h>
#include <stdint.h>

// ================================================================================== //

/*
 * The set of supporting variables are NOT changeable
 */
uint32_t jdtIn = UNDEF_INDEX;   // index of the first empty cell
uint32_t jdtOut = UNDEF_INDEX;  // index of the first occupied cell
uint32_t jdtCount = UNDEF_SIZE; // actual number of jobs in the job description table
Job jdtTable[MAX_JOBS];         // The array supporting the job description table

// ================================================================================== //
// ================================================================================== //

namespace binaries {
    void jdtInit();
    void jdtTerm();
    void jdtPrint(FILE *fout);
    uint32_t jdtLoad(FILE *fin, uint32_t maxSize);
    uint32_t jdtRandomFill(uint32_t seed, uint32_t n, uint32_t maxSize);
    double jdtNextSubmission();
    Job jdtFetchNext();
}

namespace group {
    void jdtInit();
    void jdtTerm();
    void jdtPrint(FILE *fout);
    uint32_t jdtLoad(FILE *fin, uint32_t maxSize);
    uint32_t jdtRandomFill(uint32_t seed, uint32_t n, uint32_t maxSize);
    double jdtNextSubmission();
    Job jdtFetchNext();
}

// ================================================================================== //

void jdtInit()
{
    if (soBinSelected(201))
        binaries::jdtInit();
    else
        group::jdtInit();
}

// ================================================================================== //

void jdtTerm()
{
    if (soBinSelected(202))
        binaries::jdtTerm();
    else
        group::jdtTerm();
}

// ================================================================================== //

void jdtPrint(FILE *fout)
{
    if (soBinSelected(203))
        binaries::jdtPrint(fout);
    else
        group::jdtPrint(fout);
}

// ================================================================================== //

uint32_t jdtLoad(FILE *fin, uint32_t maxSize)
{
    if (soBinSelected(204))
        return binaries::jdtLoad(fin, maxSize);
    else
        return group::jdtLoad(fin, maxSize);
}

// ================================================================================== //

uint32_t jdtRandomFill(uint32_t seed, uint32_t n, uint32_t maxSize)
{
    if (soBinSelected(205))
        return binaries::jdtRandomFill(seed, n, maxSize);
    else
        return group::jdtRandomFill(seed, n, maxSize);
}

// ================================================================================== //

double jdtNextSubmission()
{
    if (soBinSelected(206))
        return binaries::jdtNextSubmission();
    else
        return group::jdtNextSubmission();
}

// ================================================================================== //

Job jdtFetchNext()
{
    if (soBinSelected(207))
        return binaries::jdtFetchNext();
    else
        return group::jdtFetchNext();
}

// ================================================================================== //
